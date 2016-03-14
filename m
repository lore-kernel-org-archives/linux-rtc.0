Return-Path: <rtc-linux+bncBDS7HNEFSALRBDF2TS3QKGQECWAXJ6Q@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id h187si572464wme.0.2016.03.14.13.20.28
        for <rtc-linux@googlegroups.com>;
        Mon, 14 Mar 2016 13:20:28 -0700 (PDT)
Date: Mon, 14 Mar 2016 21:19:58 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] rtc: s3c: Don't print an error on probe deferral
Message-ID: <20160314201958.GB28277@piout.net>
References: <1457982308-29848-1-git-send-email-javier@osg.samsung.com>
 <1457982675.11972.119.camel@perches.com>
 <56E7119B.9060900@osg.samsung.com>
 <1457984317.11972.123.camel@perches.com>
 <56E71825.5070104@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <56E71825.5070104@osg.samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 14/03/2016 at 16:59:33 -0300, Javier Martinez Canillas wrote :
> Hello Joe,
> 
> On 03/14/2016 04:38 PM, Joe Perches wrote:
> > On Mon, 2016-03-14 at 16:31 -0300, Javier Martinez Canillas wrote:
> >> On 03/14/2016 04:11 PM, Joe Perches wrote:> > On Mon, 2016-03-14 at 16:05 -0300, Javier Martinez Canillas wrote:
> >>>>
> >>>> The clock and source clock looked up by the driver may not be available
> >>>> just because the clock controller driver was not probed yet so printing
> >>>> an error in this case is not correct and only adds confusion to users.
> >>>>
> >>>> However, knowing that a driver's probe was deferred may be useful so it
> >>>> can be printed as debug information.
> >>> []
> >>>>
> >>>> diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
> >>> []
> >>>>
> >>>> @@ -501,18 +501,27 @@ static int s3c_rtc_probe(struct platform_device *pdev)
> >>>>  
> >>>>  	info->rtc_clk = devm_clk_get(&pdev->dev, "rtc");
> >>>>  	if (IS_ERR(info->rtc_clk)) {
> >>>> -		dev_err(&pdev->dev, "failed to find rtc clock\n");
> >>>> -		return PTR_ERR(info->rtc_clk);
> >>>> +		ret = PTR_ERR(info->rtc_clk);
> >>>> +		if (ret != -EPROBE_DEFER)
> >>>> +			dev_err(&pdev->dev, "failed to find rtc clock\n");
> >>>> +		else
> >>>> +			dev_dbg(&pdev->dev, "probe deferred due rtc clock\n");
> >>>> +		return ret;
> >>>>  	}
> >>>>  	clk_prepare_enable(info->rtc_clk);
> >>>>  
> >>>>  	if (info->data->needs_src_clk) {
> >>>>  		info->rtc_src_clk = devm_clk_get(&pdev->dev, "rtc_src");
> >>>>  		if (IS_ERR(info->rtc_src_clk)) {
> >>>> -			dev_err(&pdev->dev,
> >>>> -				"failed to find rtc source clock\n");
> >>>> +			ret = PTR_ERR(info->rtc_src_clk);
> >>>> +			if (ret != -EPROBE_DEFER)
> >>>> +				dev_err(&pdev->dev,
> >>>> +					"failed to find rtc source clock\n");
> >>>> +			else
> >>>> +				dev_dbg(&pdev->dev,
> >>>> +					"probe deferred due rtc source clock\n");
> >>>>  			clk_disable_unprepare(info->rtc_clk);
> >>>> -			return PTR_ERR(info->rtc_src_clk);
> >>>> +			return ret;
> >>>>  		}
> >>>>  		clk_prepare_enable(info->rtc_src_clk);
> >>>>  	}
> >>> Maybe the debug logging messages could be object->action like:
> >>>
> >>> 	rtc clock probe deferred
> >>> 	rtc source clock probe deferred
> >>>
> >> I found your suggested messages harder to read and more confusing. The
> >> action that happens is a probe function deferral and that is caused by
> >> a missing resource needed by the driver (clocks in this case).
> >>
> >> But your messages seems to imply that the probe deferred action happens
> >> to a clock, it sounds like "rtc clock disabled" and that's not correct.
> > 
> > OK, then please change "due" to "due to" or "for" in your messages
> > because they make little sense now.
> >
> 
> I don't think they make little sense now since even a non-native english
> speaker like me can understand it :)
> 
> But yes, it's cryptic at the very least. That's the problem with long text
> and the 80 char limit to make checkpatch.pl happy. I guess I can just move
> the message a little bit even if that will make to not be properly aligned.
> 

checkpatch will not complain for messages but it will definitively
complain if they are not properly aligned:)


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
