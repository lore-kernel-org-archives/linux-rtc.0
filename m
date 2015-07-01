Return-Path: <rtc-linux+bncBCAJFDXE4QGBBXPKZSWAKGQE6EFSMTI@googlegroups.com>
Received: from mail-wg0-x231.google.com (mail-wg0-x231.google.com. [2a00:1450:400c:c00::231])
        by gmr-mx.google.com with ESMTPS id bc3si683509wib.2.2015.06.30.17.33.32
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2015 17:33:32 -0700 (PDT)
Received: by mail-wg0-x231.google.com with SMTP id u7so22999140wgu.3
        for <rtc-linux@googlegroups.com>; Tue, 30 Jun 2015 17:33:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <21906.33882.783551.610854@linux-qknr.fritz.box>
References: <1435642598-5073-1-git-send-email-adrianhuang0701@gmail.com>
	<21906.33882.783551.610854@linux-qknr.fritz.box>
Date: Wed, 1 Jul 2015 08:33:32 +0800
Message-ID: <CAHKZfL2-6yi2qU=J+r5ui8nyAfMGS+R0ozgb8dZCSuNJYmz6Yg@mail.gmail.com>
Subject: [rtc-linux] Re: [RFC PATCH v3 0/2] rtc: Prevent the automatic reboot
 after powering off the system
From: Huang Adrian <adrianhuang0701@gmail.com>
To: Egbert Eich <eich@suse.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>, John Stultz <john.stultz@linaro.org>,
	Diego Ercolani <diego.ercolani@gmail.com>, Nagananda Chumbalkar <nchumbalkar@lenovo.com>,
	Max Asbock <amax@lenovo.com>, Adrian Huang <ahuang12@lenovo.com>
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

> Adrian,
>
> I've tested this, it works for me. Thanks!
>
> Tested-by: Egbert Eich <eich@suse.de>
>

Nice! Thanks for testing, Egbert.

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
