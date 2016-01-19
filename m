Return-Path: <robert.jarzmik@free.fr>
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Alessandro Zummo <a.zummo@towertech.it>
Cc: Rob Herring <robh@kernel.org>,  rtc-linux@googlegroups.com,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: sa1100: detect rcnr overflow with dates after 2038
References: <1453165031-29194-1-git-send-email-alexandre.belloni@free-electrons.com>
Date: Tue, 19 Jan 2016 21:16:11 +0100
In-Reply-To: <1453165031-29194-1-git-send-email-alexandre.belloni@free-electrons.com>
	(Alexandre Belloni's message of "Tue, 19 Jan 2016 01:57:11 +0100")
Message-ID: <87si1tcol0.fsf@belgarion.home>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <rtc-linux.googlegroups.com>

Alexandre Belloni <alexandre.belloni@free-electrons.com> writes:

> rcnr will overflow in 2038, detect that overflow when setting the time and
> get rid of the deprecated rtc_tm_to_time()
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Hi Alexandre,

That's very nice, but doesn't that limitation touch almost all drivers, and
could benefit from a global solution in rtc_set_time() ?

What I'm thinking of is a field in rtc_device, a u64 which represents the
maximal time that can be set (or 0 if no maximum). rtc_set_time() would check
against that maximum and return -EINVAL.

For the rtc drivers, upon registration they can modify this value to set up this
clamp. This will require to set only a value in each driver, which looks more
robust to me.

Alessandro, what do you think ?

Cheers.

--
Robert
