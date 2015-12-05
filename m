Return-Path: <rtc-linux+bncBDDJNTW5VUMBBYMHRGZQKGQEVVN23BI@googlegroups.com>
Received: from mail-vk0-x229.google.com (mail-vk0-x229.google.com. [2607:f8b0:400c:c05::229])
        by gmr-mx.google.com with ESMTPS id g91si842136vki.3.2015.12.04.17.54.41
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Dec 2015 17:54:41 -0800 (PST)
Received: by mail-vk0-x229.google.com with SMTP id a188so76726687vkc.0
        for <rtc-linux@googlegroups.com>; Fri, 04 Dec 2015 17:54:41 -0800 (PST)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <CAD=FV=VLVmJQbY45De7qyg9AsW-VDqKfvj7MHMWXiGCrrx6WDA@mail.gmail.com>
References: <1449107584-3192-1-git-send-email-jwerner@chromium.org>
	<CAD=FV=VVU0ucrL9gsMGKBwMCg_d6aTZWXTpxwNmfNp0k0BzbdQ@mail.gmail.com>
	<CAODwPW_xoF8KYRPWvSrs89F-ZKxWMC4_Gp-vdEYENfzESin=ig@mail.gmail.com>
	<CAD=FV=VLVmJQbY45De7qyg9AsW-VDqKfvj7MHMWXiGCrrx6WDA@mail.gmail.com>
Date: Fri, 4 Dec 2015 17:54:40 -0800
Message-ID: <CAODwPW939ZrmGsspk42BU=U+hca4hyT4W0ceOZCVWtu057i58A@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH] RTC: RK808: Work around hardware bug on
 November 31st
From: Julius Werner <jwerner@chromium.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Julius Werner <jwerner@chromium.org>, Andrew Morton <akpm@linux-foundation.org>,
	Alessandro Zummo <a.zummo@towertech.it>, Sonny Rao <sonnyrao@chromium.org>,
	Chris Zhong <zyw@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

> How would such a hook work?  If userspace sees the system suspend on
> Nov 30th and sees the system wake up on Dec 1st, how does it know
> whether it should adjust?  If it's truly Dec 1st then the kernel will
> have adjusted the date from Nov 31st to Dec 1st.  If it's truly Dec
> 2nd then the kernel will not have adjusted the date and the RTC will
> have ticked past Nov 31 and onto Dec 1st.  Userspace can't tell.
> Userspace could try to parse "dmesg" and look to see if the kernel
> adjusted, but that's ugly.

Good point, I didn't think that through far enough. I guess parsing
dmesg would be an option, but a pretty ugly one and it wouldn't be
guaranteed to work if you got an early boot kernel crash after the
correction. So, really, it seems like there's no reliable way to fix
this for S5 (unless we start doing crazy things like writing to disk
from kernel code).

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
