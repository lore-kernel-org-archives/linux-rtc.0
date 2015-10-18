Return-Path: <rtc-linux+bncBDS7HNEFSALRBN6JROYQKGQEJPL3DIA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id o3si319038wiz.1.2015.10.17.17.15.50
        for <rtc-linux@googlegroups.com>;
        Sat, 17 Oct 2015 17:15:50 -0700 (PDT)
Date: Sun, 18 Oct 2015 02:15:50 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Sekhar Nori <nsekhar@ti.com>,
	Kevin Hilman <khilman@deeprootsystems.com>,
	Miguel Aguilar <miguel.aguilar@ridgerun.com>
Subject: [rtc-linux] Re: [PATCH] rtc: davinci: remove incorrect reference to
 probe function
Message-ID: <20151018001550.GY3421@piout.net>
References: <5677325.oZsHpDNL2Z@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <5677325.oZsHpDNL2Z@wuerfel>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 12/10/2015 at 15:14:05 +0200, Arnd Bergmann wrote :
> The davinci rtc driver uses the module_platform_driver_probe()
> helper to call the probe function and mark it as __init, but
> it also puts a reference into its davinci_rtc_driver function.
> 
> This will crash if we ever get a deferred probe and the probe
> function is called again after the init section has been removed.
> kbuild warns about this:
> 
> WARNING: vmlinux.o(.data+0x1aa2b4): Section mismatch in reference from the variable davinci_rtc_driver to the function .init.text:davinci_rtc_probe()
> The variable davinci_rtc_driver references
> the function __init davinci_rtc_probe()
> 
> This patch removes the .probe callback from the platform driver,
> which avoids those problems.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
