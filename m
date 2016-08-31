Return-Path: <rtc-linux+bncBCU23FWZQ4FBBN5OTS7AKGQE4AEWB5I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mx.tkos.co.il (guitar.tcltek.co.il. [192.115.133.116])
        by gmr-mx.google.com with ESMTPS id y7si2973053wmd.0.2016.08.31.10.43.18
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2016 10:43:19 -0700 (PDT)
Date: Wed, 31 Aug 2016 20:43:15 +0300
From: Baruch Siach <baruch@tkos.co.il>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	kernel-janitors@vger.kernel.org, linux-tegra@vger.kernel.org,
	Alexandre Courbot <gnurou@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, Wan ZongShun <mcuos.com@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Eddie Huang <eddie.huang@mediatek.com>,
	linux-mediatek@lists.infradead.org
Subject: [rtc-linux] Re: [PATCH] rtc: constify rtc_class_ops structures
Message-ID: <20160831174315.4djfepwsrxmuhp56@tarshish>
References: <1472630725-25465-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1472630725-25465-1-git-send-email-Julia.Lawall@lip6.fr>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Julia,

On Wed, Aug 31, 2016 at 10:05:25AM +0200, Julia Lawall wrote:
> Check for rtc_class_ops structures that are only passed to
> devm_rtc_device_register, rtc_device_register,
> platform_device_register_data, all of which declare the corresponding
> parameter as const.  Declare rtc_class_ops structures that have these
> properties as const.

[...]

> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

For rtc-digicolor.c:

Acked-by: Baruch Siach <baruch@tkos.co.il>

Thanks,
baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
