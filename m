Date: Wed, 22 Jul 2015 22:23:12 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, a.zummo@towertech.it,
	rtc-linux@googlegroups.com, workgroup.linux@csr.com,
	Guo Zeng <guo.zeng@csr.com>, Barry Song <Baohua.Song@csr.com>
Subject: Re: [rtc-linux] [PATCH] drivers/rtc/rtc-sirfsoc.c: move to regmap
 APIs from platform-specific APIs
Message-ID: <20150722202312.GK2853@piout.net>
References: <1436837498-6962-1-git-send-email-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436837498-6962-1-git-send-email-21cnbao@gmail.com>
List-ID: <rtc-linux.googlegroups.com>

On 14/07/2015 at 01:31:38 +0000, Barry Song wrote :
> From: Guo Zeng <guo.zeng@csr.com>
> 
> The current codes use CSR platform specific API exported by machine
> codes to read/write RTC registers. they are:
> sirfsoc_rtc_iobrg_readl()
> sirfsoc_rtc_iobrg_writel()
> 
> commit b1999477("ARM: prima2: move to use REGMAP APIs for rtciobrg")
> moves to regmap support, now we can move to use regmap APIs in RTC
> driver.
> 
> Signed-off-by: Guo Zeng <guo.zeng@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  drivers/rtc/rtc-sirfsoc.c | 106 +++++++++++++++++++++++++++-------------------
>  1 file changed, 63 insertions(+), 43 deletions(-)
> 
Applied after fixing a few whitespaces, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
