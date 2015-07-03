Return-Path: <rtc-linux+bncBAABBIFJ3OWAKGQEUK6CO7Q@googlegroups.com>
Received: from mx2.suse.de (cantor2.suse.de. [195.135.220.15])
        by gmr-mx.google.com with ESMTPS id t6si543904wiz.0.2015.07.03.11.29.52
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 03 Jul 2015 11:29:52 -0700 (PDT)
Date: Fri, 3 Jul 2015 20:29:25 +0200
From: Borislav Petkov <bp@suse.de>
To: Diego Ercolani <diego.ercolani@gmail.com>
Cc: Huang Adrian <adrianhuang0701@gmail.com>, Egbert Eich <eich@suse.com>,
	rtc-linux@googlegroups.com, Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <john.stultz@linaro.org>,
	Nagananda Chumbalkar <nchumbalkar@lenovo.com>,
	Max Asbock <amax@lenovo.com>, Adrian Huang <ahuang12@lenovo.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>
Subject: [rtc-linux] Re: [RFC PATCH v3 0/2] rtc: Prevent the automatic reboot
 after powering off the system
Message-ID: <20150703182925.GI2838@pd.tnic>
References: <1435642598-5073-1-git-send-email-adrianhuang0701@gmail.com>
 <CAHKZfL0H1mrj8pScggejtFStaA66zX43RZRYQnkYsZ4gVb-ojQ@mail.gmail.com>
 <CANoYJu=0L7yUfS2Z87OJXc+_+Z6DmQ_oGZvg2AygS_2DTOixxQ@mail.gmail.com>
 <20150701163946.GA30503@pd.tnic>
 <CANoYJunhbZB_P97u2Hu=i_u6-Xxk-cbe2FLHQ7skqKQyF10uTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CANoYJunhbZB_P97u2Hu=i_u6-Xxk-cbe2FLHQ7skqKQyF10uTw@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Fri, Jul 03, 2015 at 08:19:58PM +0200, Diego Ercolani wrote:
> Thank you Borislav.
> 
> Green Light for me!
> 
> It works

Thanks for testing!

Adrian, I think you can add Diego's Tested-by to your submission.

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
