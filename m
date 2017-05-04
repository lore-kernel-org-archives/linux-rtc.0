Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBFPEV3EAKGQE3COAP5A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id v4si21351wmv.1.2017.05.04.15.58.28
        for <rtc-linux@googlegroups.com>;
        Thu, 04 May 2017 15:58:28 -0700 (PDT)
Date: Fri, 5 May 2017 00:58:18 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Pan Bian <bianpan2016@163.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 1/1] rtc: snvs: fix an incorrect check of
 return value
Message-ID: <20170504225818.fjd47dlpdsi2fax6@piout.net>
References: <1492926204-9535-1-git-send-email-bianpan2016@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1492926204-9535-1-git-send-email-bianpan2016@163.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 23/04/2017 at 13:43:24 +0800, Pan Bian wrote:
> Function devm_regmap_init_mmio() returns an ERR_PTR on error. However,
> in function snvs_rtc_probe() its return value is checked against NULL.
> This patch fixes it by checking the return value with IS_ERR().
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
>  drivers/rtc/rtc-snvs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
