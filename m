Return-Path: <dhowells@redhat.com>
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAK8P3a3i0bKvG56ha9_hzO=z80sVxCQhaeFn6QW3AwbwZs3HPg@mail.gmail.com>
References: <CAK8P3a3i0bKvG56ha9_hzO=z80sVxCQhaeFn6QW3AwbwZs3HPg@mail.gmail.com> <1514026525-32538-1-git-send-email-xieyisheng1@huawei.com> <20171223134831.GB10103@kroah.com> <f7632cf5-2bcc-4d74-b912-3999937a1269@roeck-us.net> <c28ac0bc-8bd2-3dce-3167-8c0f80ec601e@c-s.fr>
To: Arnd Bergmann <arnd@arndb.de>
Cc: dhowells@redhat.com, christophe.leroy@c-s.fr,
    Guenter Roeck <linux@roeck-us.net>,
    Greg KH <gregkh@linuxfoundation.org>,
    Yisheng Xie <xieyisheng1@huawei.com>,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
    ysxie@foxmail.com, Ulf Hansson <ulf.hansson@linaro.org>,
    linux-mmc <linux-mmc@vger.kernel.org>,
    Boris Brezillon <boris.brezillon@free-electrons.com>,
    Richard Weinberger <richard@nod.at>,
    Marek Vasut <marek.vasut@gmail.com>,
    Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
    linux-mtd <linux-mtd@lists.infradead.org>,
    alsa-devel@alsa-project.org, Wim Van Sebroeck <wim@iguana.be>,
    linux-watchdog@vger.kernel.org,
    Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
    linux-fbdev@vger.kernel.org,
    Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
    Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
    Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
    Thomas Gleixner <tglx@linutronix.de>,
    Jason Cooper <jason@lakedaemon.net>,
    Marc Zyngier <marc.zyngier@arm.com>,
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
    industrypack-devel@lists.sourceforge.net, wg@grandegger.com,
    mkl@pengutronix.de, linux-can@vger.kernel.org,
    Mauro Carvalho Chehab <mchehab@kernel.org>,
    Linux Media Mailing List <linux-media@vger.kernel.org>,
    Alessandro Zummo <a.zummo@towertech.it>,
    Alexandre Belloni <alexandre.belloni@free-electrons.com>,
    linux-rtc@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>,
    Jani Nikula <jani.nikula@linux.intel.com>,
    Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
    dri-devel <dri-devel@lists.freedesktop.org>,
    Kalle Valo <kvalo@codeaurora.org>,
    linux-wireless <linux-wireless@vger.kernel.org>,
    linux-spi <linux-spi@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
    IDE-ML <linux-ide@vger.kernel.org>,
    Bjorn Helgaas <bhelgaas@google.com>,
    linux-pci <linux-pci@vger.kernel.org>, devel@driverdev.osuosl.org,
    Darren Hart <dvhart@infradead.org>,
    Andy Shevchenko <andy@infradead.org>,
    Platform Driver <platform-driver-x86@vger.kernel.org>,
    Jakub Kicinski <jakub.kicinski@netronome.com>,
    David Miller <davem@davemloft.net>, nios2-dev@lists.rocketboards.org,
    Networking <netdev@vger.kernel.org>,
    Vinod Koul <vinod.koul@intel.com>,
    Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
    Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH v3 00/27] kill devm_ioremap_nocache
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 04 Jan 2018 14:52:54 +0000
Message-ID: <20289.1515077574@warthog.procyon.org.uk>
List-ID: <linux-rtc.vger.kernel.org>

Arnd Bergmann <arnd@arndb.de> wrote:

> - mn10300 appears to be wrong, broken by David Howells in
>   commit 83c2dc15ce82 ("MN10300: Handle cacheable PCI regions
>   in pci_iomap()") for any driver calling ioremap() by to get uncached
>   memory,

It's not clear what the right thing to do was, given that there's an ioremap()
and an ioremap_uncached().

But the asb2305's pci_iomap() will use ioremap() (the cacheable window) if
IORESOURCE_CACHEABLE is set, but IORESOURCE_IO is not and ioremap_uncached()
otherwise.

The other supported units don't have PCI buses.

> if I understand the comment for commit 34f1bdee1910 ("mn10300: switch to
> GENERIC_PCI_IOMAP") correctly: it seems that PCI addresses include the
> 'uncached' bit by default to get the right behavior, but dropping that bit
> breaks it.

Not exactly.  The CPU has a window in the range 0xa0000000-0xbfffffff which is
an uncached view of its hardware buses.  It has another window in the range
0x80000000-0x9fffffff which is a cached view of that region.  These windows
cannot be changed and addresses above 0x80000000 are statically mapped and are
only accessible by the kernel (this is hardwired in the MMU).

So the arch has two subwindows to the PCI bus, one cached and one uncached.
These subwindows are further subdivided into ioport and iomem spaces, an SRAM
and some control registers for the CPU-PCI bridge.

David
