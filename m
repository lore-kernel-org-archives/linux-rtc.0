Return-Path: <rtc-linux+bncBCXJ7O7L3INRB3NS7GVAKGQE5ORX22Q@googlegroups.com>
Received: from mx2.suse.de (cantor2.suse.de. [195.135.220.15])
        by gmr-mx.google.com with ESMTPS id m3si163728wia.1.2015.05.21.15.17.17
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 21 May 2015 15:17:17 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-ID: <21854.22871.816868.545978@linux-qknr.fritz.box>
Date: Fri, 22 May 2015 00:16:55 +0200
From: Egbert Eich <eich@suse.com>
To: Borislav Petkov <bp@suse.de>
Cc: Diego Ercolani <diego.ercolani@gmail.com>,
    Adrian Huang <adrianhuang0701@gmail.com>,
    Egbert Eich <eich@suse.com>,
    Alessandro Zummo <a.zummo@towertech.it>,
    Alexandre Belloni <alexandre.belloni@free-electrons.com>,
    rtc-linux@googlegroups.com,
    Brecht Machiels <brecht@mos6581.org>,
    Thomas Gleixner <tglx@linutronix.de>,
    John Stultz <john.stultz@linaro.org>,
    Nagananda Chumbalkar <nchumbalkar@lenovo.com>,
    Adrian Huang <ahuang12@lenovo.com>
Subject: [rtc-linux] Re: [RFC PATCH 1/2] Revert "rtc-cmos: Add an alarm
 disable quirk"
In-Reply-To: bp@suse.de wrote on Thursday, 21 May 2015 at 22:52:49 +0200
References: <1431077665-3493-1-git-send-email-adrianhuang0701@gmail.com>
	<20150518094755.GC23662@pd.tnic>
	<CANoYJu=utAHVNPU5PnPoBXtpMPVVbFf557xbBO=2GuHyx-JNHg@mail.gmail.com>
	<20150518101248.GE23662@pd.tnic>
	<20150518160126.GI23662@pd.tnic>
	<CANoYJumsPcXhEaFCgTKvE5mFKJELN0D4F3vjOH97RHPvTeo0fw@mail.gmail.com>
	<20150521205248.GC23652@pd.tnic>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Borislav Petkov writes:
 > On Thu, May 21, 2015 at 10:25:01PM +0200, Diego Ercolani wrote:
 > > I confirm that I can shutdon the linux box with the kernel you provided
 > > here it is the bootlog
 > 
 > Cool, very nice. Thanks a lot for testing!
 > 
 > @Adrian: I think you can add Tested-by:'s to your v2.
 > 
 > Here are mine:
 > 
 > Acked-by: Borislav Petkov <bp@suse.de>
 > Tested-by: Borislav Petkov <bp@suse.de>
 > 
 > Egbert did test it on a bunch of machines too. Egbert, can you give your
 > Tested-by: too please?


You bet!

Tested-by: Egbert Eich <eich@suse.de>

Cheers,
	Egbert.

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
