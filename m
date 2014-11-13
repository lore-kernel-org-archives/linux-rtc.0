Return-Path: <Nicolas.FERRE@atmel.com>
Message-ID: <5464CAD2.8040901@atmel.com>
Date: Thu, 13 Nov 2014 16:14:26 +0100
From: Nicolas Ferre <nicolas.ferre@atmel.com>
MIME-Version: 1.0
To: Boris Brezillon <boris.brezillon@free-electrons.com>, Alessandro Zummo
	<a.zummo@towertech.it>
CC: Mark Rutland <mark.rutland@arm.com>, <devicetree@vger.kernel.org>, "Pawel
 Moll" <pawel.moll@arm.com>, Samuel Ortiz <sameo@linux.intel.com>,
	<rtc-linux@googlegroups.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Johan Hovold
	<jhovold@gmail.com>, <linux-kernel@vger.kernel.org>, Arnd Bergmann
	<arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>, Alexandre Belloni
	<alexandre.belloni@free-electrons.com>, Kumar Gala <galak@codeaurora.org>,
	Lee Jones <lee.jones@linaro.org>, Andrew Victor <linux@maxim.org.za>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v9 00/10] rtc: at91sam9: add DT support
References: <1411483725-31532-1-git-send-email-boris.brezillon@free-electrons.com> <20141020141748.063d6835@bbrezillon> <544501AE.7030706@atmel.com>
In-Reply-To: <544501AE.7030706@atmel.com>
Content-Type: text/plain; charset="ISO-8859-1"
List-ID: <rtc-linux.googlegroups.com>

On 20/10/2014 14:35, Nicolas Ferre :
> On 20/10/2014 14:17, Boris Brezillon :
>> Hi Alessandro,
>>
>> On Tue, 23 Sep 2014 16:48:35 +0200
>> Boris BREZILLON <boris.brezillon@free-electrons.com> wrote:
>>
>>> Hello,
>>>
>>> This patch series adds DT support to the atmel at91sam9 RTC driver.
>>>
>>> It also removes any machine specific inclusions to prepare the migration
>>> to multi platform kernel support, and retain the slow clock to prevent
>>> the CCF from disabling it at the end of boot.
>>
>> Nicolas was planning to take this series (except for patch 10 which was
>> already applied by Lee) in his tree for 3.19, but if you prefer to take
>> it into yours just let us know.
> 
> Absolutely, I'll happily take them for at91-3.19-drivers and push them
> through arm-soc tree unless Alessandro says otherwise.

Now in at91-3.19-drivers with Arnd's Ack on the documentation patch.
I'll sent them soon to arm-soc.

Thanks, best regards,
-- 
Nicolas Ferre
