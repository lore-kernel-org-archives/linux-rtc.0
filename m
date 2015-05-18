Return-Path: <rtc-linux+bncBAABBXMZ5CVAKGQEU3RJ4GY@googlegroups.com>
Received: from mx2.suse.de (cantor2.suse.de. [195.135.220.15])
        by gmr-mx.google.com with ESMTPS id bc3si385708wib.2.2015.05.18.09.01.33
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 May 2015 09:01:33 -0700 (PDT)
Date: Mon, 18 May 2015 18:01:26 +0200
From: Borislav Petkov <bp@suse.de>
To: Diego Ercolani <diego.ercolani@gmail.com>
Cc: Adrian Huang <adrianhuang0701@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com, Brecht Machiels <brecht@mos6581.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <john.stultz@linaro.org>,
	Rabin Vincent <rabin.vincent@stericsson.com>,
	Nagananda Chumbalkar <nchumbalkar@lenovo.com>,
	Adrian Huang <ahuang12@lenovo.com>, Egbert Eich <eich@suse.com>
Subject: [rtc-linux] Re: [RFC PATCH 1/2] Revert "rtc-cmos: Add an alarm
 disable quirk"
Message-ID: <20150518160126.GI23662@pd.tnic>
References: <1431077665-3493-1-git-send-email-adrianhuang0701@gmail.com>
 <20150518094755.GC23662@pd.tnic>
 <CANoYJu=utAHVNPU5PnPoBXtpMPVVbFf557xbBO=2GuHyx-JNHg@mail.gmail.com>
 <20150518101248.GE23662@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20150518101248.GE23662@pd.tnic>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Mon, May 18, 2015 at 12:12:48PM +0200, Borislav Petkov wrote:
> > In the meanwhile I upgraded my linux box to opensuse 13.2 with actual
> > kernel: 3.16.7-21-desktop
> 
> Ok, I'll prepare one.

Ok, I've uploaded a test kernel here - kernel-desktop, 64-bit:

http://beta.suse.com/private/bpetkov/

Let me know if you have trouble testing it.

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--

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
