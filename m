Return-Path: <okaratas@yandex.com>
From: Ozgur <okaratas@yandex.com>
To: Aishwarya Pant <aishpant@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	"linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>,
	Jonathan Corbet <corbet@lwn.net>
In-Reply-To: <20171228133132.GA3927@mordor.localdomain>
References: <20171228133132.GA3927@mordor.localdomain>
Subject: Re: rtc: sysfs: move sysfs interface to Documentation/ABI
MIME-Version: 1.0
Message-Id: <434381514470951@web50o.yandex.ru>
Date: Thu, 28 Dec 2017 17:22:31 +0300
Content-Type: text/plain
List-ID: <linux-rtc.vger.kernel.org>



28.12.2017, 16:31, "Aishwarya Pant" <aishpant@gmail.com>:
> Hi

Hello,

> In Documentation/rtc.txt, there is a description of the sysfs
> interface which could be moved to Documentation/ABI.
>
> Would such a change be useful?
>
> The ABI documentation format looks like the following:
>
> What: (the full sysfs path of the attribute)
> Date: (date of creation)
> KernelVersion: (kernel version it first showed up in)
> Contact: (primary contact)
> Description: (long description on usage)
>
> I am doing this in an exercise to move sysfs ABI interfaces (which are
> documented) to their right place i.e. in Documentation/ABI along with the rest.

Do I understand right? Are you want to make the rtc.txt part the same format as ABI folder?
for example create to RTC folder and add /dev/rtc what, date, kernelversion, contact right?

This can be a good idea and I can help.

> Aishwarya

Ozgur
