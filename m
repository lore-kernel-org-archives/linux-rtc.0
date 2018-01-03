Return-Path: <arndbergmann@gmail.com>
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <c28ac0bc-8bd2-3dce-3167-8c0f80ec601e@c-s.fr>
References: <1514026525-32538-1-git-send-email-xieyisheng1@huawei.com>
 <20171223134831.GB10103@kroah.com> <f7632cf5-2bcc-4d74-b912-3999937a1269@roeck-us.net>
 <c28ac0bc-8bd2-3dce-3167-8c0f80ec601e@c-s.fr>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 3 Jan 2018 17:14:59 +0100
Message-ID: <CAK8P3a3i0bKvG56ha9_hzO=z80sVxCQhaeFn6QW3AwbwZs3HPg@mail.gmail.com>
Subject: Re: [PATCH v3 00/27] kill devm_ioremap_nocache
To: christophe leroy <christophe.leroy@c-s.fr>
Cc: Guenter Roeck <linux@roeck-us.net>, Greg KH <gregkh@linuxfoundation.org>,
	Yisheng Xie <xieyisheng1@huawei.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ysxie@foxmail.com,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>,
	Boris Brezillon <boris.brezillon@free-electrons.com>, Richard Weinberger <richard@nod.at>,
	Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
	linux-mtd <linux-mtd@lists.infradead.org>, alsa-devel@alsa-project.org,
	Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>,
	"open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	industrypack-devel@lists.sourceforge.net, wg@grandegger.com,
	mkl@pengutronix.de, linux-can@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>, Linux Media Mailing List <linux-media@vger.kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-rtc@vger.kernel.org,
	Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>,
	Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
	dri-devel <dri-devel@lists.freedesktop.org>, Kalle Valo <kvalo@codeaurora.org>,
	linux-wireless <linux-wireless@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>,
	Tejun Heo <tj@kernel.org>, IDE-ML <linux-ide@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci <linux-pci@vger.kernel.org>,
	devel@driverdev.osuosl.org, Darren Hart <dvhart@infradead.org>,
	Andy Shevchenko <andy@infradead.org>, Platform Driver <platform-driver-x86@vger.kernel.org>,
	Jakub Kicinski <jakub.kicinski@netronome.com>, David Miller <davem@davemloft.net>,
	"moderated list:NIOS2 ARCHITECTURE" <nios2-dev@lists.rocketboards.org>, Networking <netdev@vger.kernel.org>,
	Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	dmaengine@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
	David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-rtc.vger.kernel.org>

On Sun, Dec 24, 2017 at 9:55 AM, christophe leroy
<christophe.leroy@c-s.fr> wrote:
> Le 23/12/2017 =C3=A0 16:57, Guenter Roeck a =C3=A9crit :
>>
>> On 12/23/2017 05:48 AM, Greg KH wrote:
>>>
>>> On Sat, Dec 23, 2017 at 06:55:25PM +0800, Yisheng Xie wrote:
>>>>
>>>> Hi all,
>>>>
>>>> When I tried to use devm_ioremap function and review related code, I
>>>> found
>>>> devm_ioremap and devm_ioremap_nocache is almost the same with each
>>>> other,
>>>> except one use ioremap while the other use ioremap_nocache.
>>>
>>>
>>> For all arches?  Really?  Look at MIPS, and x86, they have different
>>> functions.
>>>
>>
>> Both mips and x86 end up mapping the same function, but other arches
>> don't.
>> mn10300 is one where ioremap and ioremap_nocache are definitely differen=
t.
>
>
> alpha: identical
> arc: identical
> arm: identical
> arm64: identical
> cris: different        <=3D=3D
> frv: identical
> hexagone: identical
> ia64: different        <=3D=3D
> m32r: identical
> m68k: identical
> metag: identical
> microblaze: identical
> mips: identical
> mn10300: different     <=3D=3D
> nios: identical
> openrisc: different    <=3D=3D
> parisc: identical
> riscv: identical
> s390: identical
> sh: identical
> sparc: identical
> tile: identical
> um: rely on asm/generic
> unicore32: identical
> x86: identical
> asm/generic (no mmu): identical
>
> So 4 among all arches seems to have ioremap() and ioremap_nocache() being
> different.
>
> Could we have a define set by the 4 arches on which ioremap() and
> ioremap_nocache() are different, something like
> HAVE_DIFFERENT_IOREMAP_NOCACHE ?

I wonder if those are actually correct or not. What I found looking at
those architectures:

- openrisc only has one driver using ioremap (drivers/net/ethernet/ethoc.c)
  and that calls ioremap_nocache(). Presumably the authors went with the
  implementation for ioremap that made sense (using default attributes)
  rather than the one that actually works (using uncached).

- On ia64, ioremap() checks the attributes for the physical
  address based on firmware tables and then picks either cached
  or uncached mappings. ioremap_nocache() does the same but
  returns NULL instead of a cached mapping for anything that is
  not an MMIO address. Presumably it would just work to always
  call ioremap().

- mn10300 appears to be wrong, broken by David Howells in
  commit 83c2dc15ce82 ("MN10300: Handle cacheable PCI regions
  in pci_iomap()") for any driver calling ioremap() by to get uncached
  memory, if I understand the comment for commit 34f1bdee1910
   ("mn10300: switch to GENERIC_PCI_IOMAP") correctly: it
  seems that PCI addresses include the 'uncached' bit by default
  to get the right behavior, but dropping that bit breaks it.

- cris seems similar to mn10300 in hardware, using an phys address
  bit for uncached access. There are two callers in arch code that
  appear to rely on the cachable output of ioremap()
arch/cris/arch-v32/kernel/signal.c:
__ioremap_prot(virt_to_phys(data), PAGE_SIZE, PAGE_SIGNAL_TRAMPOLINE);
arch/cris/arch-v32/mm/intmem.c:         intmem_virtual =3D
ioremap(MEM_INTMEM_START + RESERVED_SIZE,
  It's unclear whether ioremap_nocache() actually has any users
  on cris, or whether it was only added for compile-time testing,
  and calling plain ioremap() would always work too (assuming we
  pass the phys address with the uncached-bit set).

       Arnd
