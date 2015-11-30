Return-Path: <rtc-linux+bncBDQ2L75W5QGBBOHW6GZAKGQEMGQ346Y@googlegroups.com>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk. [2400:8900::f03c:91ff:fedb:4f4])
        by gmr-mx.google.com with ESMTPS id fg10si5408966pad.0.2015.11.30.08.35.37
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 30 Nov 2015 08:35:38 -0800 (PST)
Date: Mon, 30 Nov 2015 16:34:13 +0000
From: Mark Brown <broonie@kernel.org>
To: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>,
	Joshua Kinard <kumba@gentoo.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Jiri Slaby <jslaby@suse.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Kumar Gala <galak@codeaurora.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Rob Herring <robh+dt@kernel.org>, John Crispin <blogic@openwrt.org>,
	Jayachandran C <jchandra@broadcom.com>, linux-spi@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Ray Jui <rjui@broadcom.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Tejun Heo <tj@kernel.org>, Michal Simek <michal.simek@xilinx.com>,
	Andrew Bresticker <abrestic@chromium.org>,
	Russell Joyce <russell.joyce@york.ac.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Grant Likely <grant.likely@linaro.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Pawel Moll <pawel.moll@arm.com>, linux-pci@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ley Foon Tan <lftan@altera.com>, devicetree@vger.kernel.org,
	Jiang Liu <jiang.liu@linux.intel.com>, linux-serial@vger.kernel.org,
	rtc-linux@googlegroups.com, Rob Herring <robh@kernel.org>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	Wolfram Sang <wsa@the-dreams.de>, Duc Dang <dhdang@apm.com>,
	Frank Rowand <frowand.list@gmail.com>,
	Vinod Koul <vinod.koul@intel.com>,
	Markos Chandras <markos.chandras@imgtec.com>,
	Michal Simek <monstr@monstr.eu>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Joe Perches <joe@perches.com>, Jingoo Han <jingoohan1@gmail.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	=?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
	dmaengine@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>,
	linux-i2c@vger.kernel.org
Message-ID: <20151130163413.GB1929@sirena.org.uk>
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pI6hLdwVzam1XFuA"
In-Reply-To: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
Subject: [rtc-linux] Re: [PATCH 00/28] MIPS Boston board support
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

--pI6hLdwVzam1XFuA
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Mon, Nov 30, 2015 at 04:21:25PM +0000, Paul Burton wrote:
> This series introduces support for the Imagination Technologies MIPS
> Boston development board. Boston is an FPGA-based development board
> akin to the much older Malta board, built around a Xilinx FPGA running
> a MIPS CPU & other logic including a PCIe root port connected to an
> Intel EG20T Platform Controller Hub. This provides a base set of
> peripherals including SATA, USB, SD/MMC, ethernet, I2C & GPIOs. PCIe
> slots are also present for expansion.

This is an insanely big CC list :(

What are the interdependencies here - does this really need to be one
patch series or can the individual driver changes go in separately?  The
latter is more normal, usually rather than a single patch series we just
have each driver sent by itself since that's usually easier to handle
and avoids the massive CC lists.

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

--pI6hLdwVzam1XFuA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWXHqEAAoJECTWi3JdVIfQJSUH/iIgPfd2b5fhUdpCuloKrkzo
ez7mkxbm3A2j3pKg0G57M4IEOD1UHHBQdACn9Gn38+UCLVdK2VoDpY+xxpf0bUbB
aWm0a1vnjxwyTW5lSEkeR0i6EzMuFliUJnIsdv9yrmwUdm8Z0zJTYaLRm2rKsgR3
kQLDe+kzzuf3qKW0mVcOL8y4rb/keG79c35wSXn4heWbFL7FCAUmVZ0bhcOkeLP+
O9T7D/fqnlT4+gOvBBlglzHBjWY8JUYJiccHFfccRZJ3hOO973bHQi8QcGhS06C3
LFww/Secx7tTiUXfdXo5sD0dAJwN7mG8sBrYAmZPBcW1TYn6wzCxFMK9XkLVA9k=
=7ym9
-----END PGP SIGNATURE-----

--pI6hLdwVzam1XFuA--
