Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Boris BREZILLON <boris.brezillon@free-electrons.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>, Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Johan Hovold <jhovold@gmail.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v8 00/10] rtc: at91sam9: add DT support
Date: Tue, 23 Sep 2014 14:57:37 +0200
Message-ID: <2804695.hx0ZOj3D5K@wuerfel>
In-Reply-To: <1411471444-2764-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1411471444-2764-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <rtc-linux.googlegroups.com>

On Tuesday 23 September 2014 13:23:54 Boris BREZILLON wrote:
> 
> This patch series adds DT support to the atmel at91sam9 RTC driver.
> 
> It also removes any machine specific inclusions to prepare the migration
> to multi platform kernel support, and retain the slow clock to prevent
> the CCF from disabling it at the end of boot.
>   
> 

Looks good to me, please add

Acked-by: Arnd Bergmann <arnd@arndb.de>

once you have addressed the remaining comments from Johan and me.

	Arnd
