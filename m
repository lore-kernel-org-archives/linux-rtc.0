Return-Path: <robert.jarzmik@free.fr>
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>,  Alexandre Belloni <alexandre.belloni@free-electrons.com>,  Eric Miao <eric.y.miao@gmail.com>,  Haojian Zhuang <haojian.zhuang@gmail.com>,  Alessandro Zummo <a.zummo@towertech.it>,  rtc-linux@googlegroups.com,  Arnd Bergmann <arnd@arndb.de>,  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/6] SA1100/PXA RTC clean-up
References: <1431529350-4597-1-git-send-email-robh@kernel.org>
Date: Fri, 15 May 2015 13:13:28 +0200
In-Reply-To: <1431529350-4597-1-git-send-email-robh@kernel.org> (Rob Herring's
	message of "Wed, 13 May 2015 10:02:24 -0500")
Message-ID: <87pp62jdpj.fsf@belgarion.home>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <rtc-linux.googlegroups.com>

Rob Herring <robh@kernel.org> writes:

> A git branch is here[4]. I've tested sa1100-rtc on PXA1928. I need help
> testing on PXA27x/3xx.
Hi Rob,

I tested on PXA27x. It works for the boards which used pxa-rtc.
For the others, their defconfig become broken, because the pxa boards with
sa1100-rtc do not work anymore. And of course no .config manipulation will fix
this, because PXA architecture is denied the sa1100-rtc driver.

As a consequence, these boards should transition from sa1100-rtc to pxa-rtc to
get back a working rtc, amongst which :
	cm_x2xx_defconfig
	em_x270_defconfig
	h5000_defconfig
	jornada720_defconfig
	magician_defconfig
	palmz72_defconfig
	pcm027_defconfig
	trizeps4_defconfig
	viper_defconfig
	xcep_defconfig

I think you should at least Cc the maintainers of these boards to see their
reaction. They should be aware of the impacts and comment.

I'll make a test for pxa3xx in the next week.

Cheers.

--
Robert
