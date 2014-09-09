Date: Tue, 9 Sep 2014 11:39:20 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Boris BREZILLON <boris.brezillon@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] rtc: at91sam9: add DT support
Message-ID: <20140909093920.GI14623@piout.net>
References: <1410255035-26775-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1410255035-26775-1-git-send-email-boris.brezillon@free-electrons.com>
List-ID: <rtc-linux.googlegroups.com>

On 09/09/2014 at 11:30:29 +0200, Boris Brezillon wrote :
> Hello,
> 
> This patch series adds DT support to the atmel at91sam9 RTC driver.
> 
> It also removes any machine specific inclusions to prepare the migration
> to multi platform kernel support, and retain the slow clock to prevent
> the CCF from disabling it at the end of boot.
> 

Whole series is:

Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
