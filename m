Return-Path: <rtc-linux+bncBAABB7536GZAKGQEAFGZOXI@googlegroups.com>
Received: from mail1.bemta14.messagelabs.com (mail1.bemta14.messagelabs.com. [193.109.254.114])
        by gmr-mx.google.com with ESMTPS id k189si752442wmg.2.2015.11.30.06.32.30
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2015 06:32:30 -0800 (PST)
From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Enrico Scholz
	<enrico.scholz@sigma-chemnitz.de>
CC: "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, "Alessandro
 Zummo" <a.zummo@towertech.it>, Support Opensource
	<Support.Opensource@diasemi.com>
Subject: RE: [rtc-linux] Re: [PATCH] rtc-da9063: avoid writing undefined data
 to rtc
Date: Mon, 30 Nov 2015 14:32:29 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB70173D2765B@SW-EX-MBX02.diasemi.com>
References: <1448625775-15531-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
 <20151127150158.GC4268@piout.net>
 <ly1tbbea3m.fsf@ensc-virt.intern.sigma-chemnitz.de>
 <20151127155729.GB22136@piout.net>
In-Reply-To: <20151127155729.GB22136@piout.net>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Sent: 27 November 2015 15:57 Alexandre Belloni wrote:

> Subject: Re: [rtc-linux] Re: [PATCH] rtc-da9063: avoid writing undefined data to rtc
> On 27/11/2015 at 16:27:25 +0100, Enrico Scholz wrote :
> >
> > I think, it is always a bad idea to write random data from stack to a
> > device.
> 
> I agree.
> 

Hi Alexandre and Enrico,

I have double checked this morning and in these cases it is not important whether it is a 1 or a 0
written to these specific reserved bits.

But, I did intended to write a zero to the reserved bits.
Enrico's patch will make the recommendation clear.

> 
> I'll take your patch anyway, unless Steve has another opinion on that.
> 

Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
Tested-by: Steve Twiss <stwiss.opensource@diasemi.com>

Regards,
Steve

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
