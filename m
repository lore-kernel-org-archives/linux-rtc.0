Return-Path: <rtc-linux+bncBCAJFDXE4QGBBEHQ46WAKGQEEAMG3EY@googlegroups.com>
Received: from mail-wg0-x230.google.com (mail-wg0-x230.google.com. [2a00:1450:400c:c00::230])
        by gmr-mx.google.com with ESMTPS id fj7si514239wib.3.2015.07.05.20.37.52
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Jul 2015 20:37:52 -0700 (PDT)
Received: by wguu7 with SMTP id u7so128741987wgu.3
        for <rtc-linux@googlegroups.com>; Sun, 05 Jul 2015 20:37:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150703182925.GI2838@pd.tnic>
References: <1435642598-5073-1-git-send-email-adrianhuang0701@gmail.com>
	<CAHKZfL0H1mrj8pScggejtFStaA66zX43RZRYQnkYsZ4gVb-ojQ@mail.gmail.com>
	<CANoYJu=0L7yUfS2Z87OJXc+_+Z6DmQ_oGZvg2AygS_2DTOixxQ@mail.gmail.com>
	<20150701163946.GA30503@pd.tnic>
	<CANoYJunhbZB_P97u2Hu=i_u6-Xxk-cbe2FLHQ7skqKQyF10uTw@mail.gmail.com>
	<20150703182925.GI2838@pd.tnic>
Date: Mon, 6 Jul 2015 11:37:51 +0800
Message-ID: <CAHKZfL1TQV6r1-oXV7jZ=HxRRbVPGpEr1ZLfoOnAQ=JG=+7K5Q@mail.gmail.com>
Subject: [rtc-linux] Re: [RFC PATCH v3 0/2] rtc: Prevent the automatic reboot
 after powering off the system
From: Huang Adrian <adrianhuang0701@gmail.com>
To: Borislav Petkov <bp@suse.de>
Cc: Diego Ercolani <diego.ercolani@gmail.com>, Egbert Eich <eich@suse.com>, rtc-linux@googlegroups.com,
	Thomas Gleixner <tglx@linutronix.de>, John Stultz <john.stultz@linaro.org>,
	Nagananda Chumbalkar <nchumbalkar@lenovo.com>, Max Asbock <amax@lenovo.com>,
	Adrian Huang <ahuang12@lenovo.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>
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

On Sat, Jul 4, 2015 at 2:29 AM, Borislav Petkov <bp@suse.de> wrote:
> On Fri, Jul 03, 2015 at 08:19:58PM +0200, Diego Ercolani wrote:
> Thanks for testing!
>
> Adrian, I think you can add Diego's Tested-by to your submission.

Yes. I'll add Diego's Tested-by and send v4 later.

Thanks, Diego and Boris.

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
