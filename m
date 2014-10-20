Return-Path: <boris.brezillon@free-electrons.com>
Date: Mon, 20 Oct 2014 14:17:48 +0200
From: Boris Brezillon <boris.brezillon@free-electrons.com>
To: Boris BREZILLON <boris.brezillon@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe
 Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni
 <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>,
 Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com, Samuel
 Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Johan
 Hovold <jhovold@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll
 <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell
 <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v9 00/10] rtc: at91sam9: add DT support
Message-ID: <20141020141748.063d6835@bbrezillon>
In-Reply-To: <1411483725-31532-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1411483725-31532-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <rtc-linux.googlegroups.com>

Hi Alessandro,

On Tue, 23 Sep 2014 16:48:35 +0200
Boris BREZILLON <boris.brezillon@free-electrons.com> wrote:

> Hello,
> 
> This patch series adds DT support to the atmel at91sam9 RTC driver.
> 
> It also removes any machine specific inclusions to prepare the migration
> to multi platform kernel support, and retain the slow clock to prevent
> the CCF from disabling it at the end of boot.

Nicolas was planning to take this series (except for patch 10 which was
already applied by Lee) in his tree for 3.19, but if you prefer to take
it into yours just let us know.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
