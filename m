Return-Path: <rtc-linux+bncBDKZNNNLXAHBBA6W72XAKGQECOTDDXA@googlegroups.com>
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com. [210.118.77.12])
        by gmr-mx.google.com with ESMTPS id ys2si608509pac.0.2015.08.27.17.27.47
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 27 Aug 2015 17:27:47 -0700 (PDT)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NTR002GNNY6VY30@mailout2.w1.samsung.com> for
 rtc-linux@googlegroups.com; Fri, 28 Aug 2015 01:27:42 +0100 (BST)
Subject: [rtc-linux] Re: [PATCH] rtc: Fix module autoload for
 rtc-{ab8500,max8997,s5m} drivers
To: Javier Martinez Canillas <javier@osg.samsung.com>,
 linux-kernel@vger.kernel.org
References: <1440671672-26590-1-git-send-email-javier@osg.samsung.com>
Cc: Luis de Bethencourt <luis.bg@samsung.com>,
 linux-samsung-soc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
 Sangbeom Kim <sbkim73@samsung.com>, Linus Walleij <linus.walleij@linaro.org>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 rtc-linux@googlegroups.com, linux-arm-kernel@lists.infradead.org
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <55DFAAF9.3020202@samsung.com>
Date: Fri, 28 Aug 2015 09:27:37 +0900
MIME-version: 1.0
In-reply-to: <1440671672-26590-1-git-send-email-javier@osg.samsung.com>
Content-type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 27.08.2015 19:34, Javier Martinez Canillas wrote:
> These platform drivers have a platform device ID table but the module
> alias information is not created so module autoloading will not work.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
>  drivers/rtc/rtc-ab8500.c  | 1 +
>  drivers/rtc/rtc-max8997.c | 1 +
>  drivers/rtc/rtc-s5m.c     | 1 +
>  3 files changed, 3 insertions(+)

Makes sense:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

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
