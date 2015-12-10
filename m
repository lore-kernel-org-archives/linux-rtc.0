Return-Path: <rtc-linux+bncBDE6RCFOWIARBOGPU2ZQKGQEMAK5KXI@googlegroups.com>
Received: from mail-ob0-x22d.google.com (mail-ob0-x22d.google.com. [2607:f8b0:4003:c01::22d])
        by gmr-mx.google.com with ESMTPS id kr4si259457igb.0.2015.12.10.08.26.31
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Dec 2015 08:26:31 -0800 (PST)
Received: by mail-ob0-x22d.google.com with SMTP id sd4so12906215obb.0
        for <rtc-linux@googlegroups.com>; Thu, 10 Dec 2015 08:26:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20151130163413.GB1929@sirena.org.uk>
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
	<20151130163413.GB1929@sirena.org.uk>
Date: Thu, 10 Dec 2015 17:26:31 +0100
Message-ID: <CACRpkdb2YhSbaYUXh4Dz7juObHxmWLc8Gj6UmkJ=Nv69UNfaPA@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 00/28] MIPS Boston board support
From: Linus Walleij <linus.walleij@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Paul Burton <paul.burton@imgtec.com>, Linux MIPS <linux-mips@linux-mips.org>,
	Arnd Bergmann <arnd@arndb.de>, Joshua Kinard <kumba@gentoo.org>,
	Alessandro Zummo <a.zummo@towertech.it>, Jiri Slaby <jslaby@suse.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>, Kumar Gala <galak@codeaurora.org>,
	Yijing Wang <wangyijing@huawei.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Rob Herring <robh+dt@kernel.org>, John Crispin <blogic@openwrt.org>,
	Jayachandran C <jchandra@broadcom.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Ray Jui <rjui@broadcom.com>, Richard Cochran <richardcochran@gmail.com>, Tejun Heo <tj@kernel.org>,
	Michal Simek <michal.simek@xilinx.com>, Andrew Bresticker <abrestic@chromium.org>,
	Russell Joyce <russell.joyce@york.ac.uk>, Thomas Gleixner <tglx@linutronix.de>,
	Grant Likely <grant.likely@linaro.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Pawel Moll <pawel.moll@arm.com>,
	linux-pci <linux-pci@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ralf Baechle <ralf@linux-mips.org>, Alexandre Courbot <gnurou@gmail.com>,
	Zhou Wang <wangzhou1@hisilicon.com>, Andrew Morton <akpm@linux-foundation.org>,
	Ley Foon Tan <lftan@altera.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Jiang Liu <jiang.liu@linux.intel.com>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, Rob Herring <robh@kernel.org>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Wolfram Sang <wsa@the-dreams.de>, Duc Dang <dhdang@apm.com>,
	Frank Rowand <frowand.list@gmail.com>, Vinod Koul <vinod.koul@intel.com>,
	Markos Chandras <markos.chandras@imgtec.com>, Michal Simek <monstr@monstr.eu>,
	Marc Zyngier <marc.zyngier@arm.com>, Dan Williams <dan.j.williams@intel.com>,
	Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Joe Perches <joe@perches.com>, Jingoo Han <jingoohan1@gmail.com>,
	Hauke Mehrtens <hauke@hauke-m.de>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
	dmaengine@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Mon, Nov 30, 2015 at 5:34 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Nov 30, 2015 at 04:21:25PM +0000, Paul Burton wrote:
>> This series introduces support for the Imagination Technologies MIPS
>> Boston development board. Boston is an FPGA-based development board
>> akin to the much older Malta board, built around a Xilinx FPGA running
>> a MIPS CPU & other logic including a PCIe root port connected to an
>> Intel EG20T Platform Controller Hub. This provides a base set of
>> peripherals including SATA, USB, SD/MMC, ethernet, I2C & GPIOs. PCIe
>> slots are also present for expansion.
>
> This is an insanely big CC list :(
>
> What are the interdependencies here - does this really need to be one
> patch series or can the individual driver changes go in separately?

I took the two GPIO patches and ran off with them at least.

Yours,
Linus Walleij

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
