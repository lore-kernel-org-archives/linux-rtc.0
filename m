Return-Path: <rtc-linux+bncBCXJ7O7L3INRB4EIZKWAKGQEKN333VA@googlegroups.com>
Received: from mx2.suse.de (cantor2.suse.de. [195.135.220.15])
        by gmr-mx.google.com with ESMTPS id da3si599393wib.1.2015.06.30.04.58.40
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 30 Jun 2015 04:58:40 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-ID: <21906.33882.783551.610854@linux-qknr.fritz.box>
Date: Tue, 30 Jun 2015 13:58:18 +0200
From: Egbert Eich <eich@suse.com>
To: Adrian Huang <adrianhuang0701@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
    Alessandro Zummo <a.zummo@towertech.it>,
    rtc-linux@googlegroups.com,
    Borislav Petkov <bp@suse.de>,
    Thomas Gleixner <tglx@linutronix.de>,
    John Stultz <john.stultz@linaro.org>,
    Egbert Eich <eich@suse.com>,
    Diego Ercolani <diego.ercolani@gmail.com>,
    Nagananda Chumbalkar <nchumbalkar@lenovo.com>,
    Max Asbock <amax@lenovo.com>,
    Adrian Huang <ahuang12@lenovo.com>
Subject: [rtc-linux] Re: [RFC PATCH v3 0/2] rtc: Prevent the automatic reboot
 after powering off the system
In-Reply-To: adrianhuang0701@gmail.com wrote on Tuesday, 30 June 2015 at 13:36:36 +0800
References: <1435642598-5073-1-git-send-email-adrianhuang0701@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Adrian Huang writes:
 > Changes from v2:
 >   * Drop the approach "Clear interrupt flag if alarm time is less
 >     equal to now+1". Instead, cancel the alarm if the configured 
 >     alarm time is equal to now+1 seconds. (Suggested by Alexandre)

Adrian,

I've tested this, it works for me. Thanks!

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
