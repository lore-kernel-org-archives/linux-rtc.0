Return-Path: <rtc-linux+bncBCH4V2OOTYHBBLUCUC7AKGQEVHAFZFQ@googlegroups.com>
Received: from mail-wm0-x229.google.com (mail-wm0-x229.google.com. [2a00:1450:400c:c09::229])
        by gmr-mx.google.com with ESMTPS id e21si65912wmc.2.2016.09.01.03.21.33
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2016 03:21:33 -0700 (PDT)
Received: by mail-wm0-x229.google.com with SMTP id 1so84641258wmz.1
        for <rtc-linux@googlegroups.com>; Thu, 01 Sep 2016 03:21:33 -0700 (PDT)
Date: Thu, 1 Sep 2016 12:21:26 +0200 (CEST)
From: "'Hans Ulli Kroll' via rtc-linux" <rtc-linux@googlegroups.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
cc: Alessandro Zummo <a.zummo@towertech.it>, kernel-janitors@vger.kernel.org,
    linux-tegra@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>,
    Thierry Reding <thierry.reding@gmail.com>,
    Stephen Warren <swarren@wwwdotorg.org>,
    Hans Ulli Kroll <ulli.kroll@googlemail.com>,
    Alexandre Belloni <alexandre.belloni@free-electrons.com>,
    linux-arm-kernel@lists.infradead.org, rtc-linux@googlegroups.com,
    linux-kernel@vger.kernel.org, Wan ZongShun <mcuos.com@gmail.com>,
    Linus Walleij <linus.walleij@linaro.org>,
    Eddie Huang <eddie.huang@mediatek.com>, linux-mediatek@lists.infradead.org,
    Baruch Siach <baruch@tkos.co.il>
Subject: [rtc-linux] Re: [PATCH] rtc: constify rtc_class_ops structures
In-Reply-To: <1472630725-25465-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <alpine.LNX.2.00.1609011219330.31401@T520>
References: <1472630725-25465-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Julia 

On Wed, 31 Aug 2016, Julia Lawall wrote:

> Check for rtc_class_ops structures that are only passed to
> devm_rtc_device_register, rtc_device_register,
> platform_device_register_data, all of which declare the corresponding
> parameter as const.  Declare rtc_class_ops structures that have these
> properties as const.
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 

> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

for drivers/rtc/rtc-gemini.c

Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
