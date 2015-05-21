Return-Path: <rtc-linux+bncBCAJFDXE4QGBB5637GVAKGQE6J73BUQ@googlegroups.com>
Received: from mail-wg0-x229.google.com (mail-wg0-x229.google.com. [2a00:1450:400c:c00::229])
        by gmr-mx.google.com with ESMTPS id p9si176394wiz.3.2015.05.21.16.44.54
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2015 16:44:54 -0700 (PDT)
Received: by mail-wg0-x229.google.com with SMTP id gq6so2378739wgb.3
        for <rtc-linux@googlegroups.com>; Thu, 21 May 2015 16:44:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150521205248.GC23652@pd.tnic>
References: <1431077665-3493-1-git-send-email-adrianhuang0701@gmail.com>
	<20150518094755.GC23662@pd.tnic>
	<CANoYJu=utAHVNPU5PnPoBXtpMPVVbFf557xbBO=2GuHyx-JNHg@mail.gmail.com>
	<20150518101248.GE23662@pd.tnic>
	<20150518160126.GI23662@pd.tnic>
	<CANoYJumsPcXhEaFCgTKvE5mFKJELN0D4F3vjOH97RHPvTeo0fw@mail.gmail.com>
	<20150521205248.GC23652@pd.tnic>
Date: Fri, 22 May 2015 07:44:54 +0800
Message-ID: <CAHKZfL1n9u=LZwYP5rFJC_MtiBL=TRroq156BAuCeUcPfvO94g@mail.gmail.com>
Subject: [rtc-linux] Re: [RFC PATCH 1/2] Revert "rtc-cmos: Add an alarm
 disable quirk"
From: Huang Adrian <adrianhuang0701@gmail.com>
To: Borislav Petkov <bp@suse.de>
Cc: Diego Ercolani <diego.ercolani@gmail.com>, Egbert Eich <eich@suse.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, rtc-linux@googlegroups.com,
	Brecht Machiels <brecht@mos6581.org>, Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <john.stultz@linaro.org>, Nagananda Chumbalkar <nchumbalkar@lenovo.com>,
	Adrian Huang <ahuang12@lenovo.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

> Cool, very nice. Thanks a lot for testing!
>

Awesome, thanks to all you guys for testing. I'm really appreciated.

> @Adrian: I think you can add Tested-by:'s to your v2.
>

Sure. I'll send v2 out later with Borislav's Acked-by/Tested-by and
Egbert's Tested-by.

@Diego: May I have your Tested-by, too?

-- Adrian

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
