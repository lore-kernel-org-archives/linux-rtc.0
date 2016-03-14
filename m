Return-Path: <rtc-linux+bncBDS7HNEFSALRBPOITS3QKGQEYRZ2AJI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id s141si665188wmd.1.2016.03.14.13.51.08
        for <rtc-linux@googlegroups.com>;
        Mon, 14 Mar 2016 13:51:08 -0700 (PDT)
Date: Mon, 14 Mar 2016 21:51:01 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Joe Perches <joe@perches.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
	linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] rtc: s3c: Don't print an error on probe deferral
Message-ID: <20160314205101.GD28277@piout.net>
References: <1457982308-29848-1-git-send-email-javier@osg.samsung.com>
 <1457982675.11972.119.camel@perches.com>
 <56E7119B.9060900@osg.samsung.com>
 <1457984317.11972.123.camel@perches.com>
 <56E71825.5070104@osg.samsung.com>
 <20160314201958.GB28277@piout.net>
 <1457987588.11972.135.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1457987588.11972.135.camel@perches.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 14/03/2016 at 13:33:08 -0700, Joe Perches wrote :
> On Mon, 2016-03-14 at 21:19 +0100, Alexandre Belloni wrote:
> > checkpatch will not complain for messages but it will definitively
> > complain if they are not properly aligned:)
> 
> checkpatch wouldn't actually complain unless the --strict option
> was used or these files were in drivers/net or drivers/staging.
> 

yeah, I'm using --strict on all the patches I receive.

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
