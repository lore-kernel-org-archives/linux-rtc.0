Return-Path: <rtc-linux+bncBDQNTZVC44FBB5MH4W4AKGQEACSLL5Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mailhost.home (mailhost.ilcode.fr. [2a01:240:fe87:2::2])
        by gmr-mx.google.com with ESMTPS id d92si697034wma.2.2016.04.21.14.19.48
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 21 Apr 2016 14:19:48 -0700 (PDT)
Date: Thu, 21 Apr 2016 23:19:40 +0200
From: Nicolas Boullis <nboullis@debian.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] rtc: ds1307: ensure that any pending alarm is
 cleared before a new alarm is enabled
Message-ID: <20160421211940.GA5622@coco.home>
References: <20160402221047.GB3600@haddock.home>
 <20160410112305.GB3603@haddock.home>
 <20160418222803.GA25196@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160418222803.GA25196@piout.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, Apr 19, 2016 at 12:28:03AM +0200, Alexandre Belloni wrote:
> Applied, thanks.

Well, you=E2=80=99re doing the hard work of maintaining the RTC subsystem, =
while=20
I am only scratching my itch, so thank YOU for your work.

--=20
Nicolas Boullis

--=20
--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
