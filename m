Return-Path: <rtc-linux+bncBAABBUXP4PBQKGQEM7MWGFI@googlegroups.com>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk. [2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by gmr-mx.google.com with ESMTPS id 133si175032wmj.1.2017.01.13.07.52.50
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 13 Jan 2017 07:52:50 -0800 (PST)
Date: Fri, 13 Jan 2017 15:52:29 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Amelie Delaunay <amelie.delaunay@st.com>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	rtc-linux@googlegroups.com, linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] Re: [PATCH 3/3] rtc: stm32: use 32-bit cast for BIT() macro
Message-ID: <20170113155229.GS14217@n2100.armlinux.org.uk>
References: <20170113153311.2611510-1-arnd@arndb.de>
 <20170113153311.2611510-3-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170113153311.2611510-3-arnd@arndb.de>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Fri, Jan 13, 2017 at 04:32:53PM +0100, Arnd Bergmann wrote:
> -#define PWR_CR_DBP			BIT(8)
> +#define PWR_CR_DBP			(u32)BIT(8)

Shouldn't that have parens around it as it's no longer a simple expression.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
