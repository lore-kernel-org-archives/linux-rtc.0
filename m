Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBIHEV3EAKGQEGVTWGOA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id b84si19547wmh.2.2017.05.04.15.58.40
        for <rtc-linux@googlegroups.com>;
        Thu, 04 May 2017 15:58:40 -0700 (PDT)
Date: Fri, 5 May 2017 00:58:29 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Pan Bian <bianpan201602@163.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Pan Bian <bianpan2016@163.com>
Subject: [rtc-linux] Re: [PATCH 1/1] rtc: gemini: add return value validation
Message-ID: <20170504225829.2cjck4vab7d4swu5@piout.net>
References: <1492951687-16777-1-git-send-email-bianpan201602@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1492951687-16777-1-git-send-email-bianpan201602@163.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 23/04/2017 at 20:48:07 +0800, Pan Bian wrote:
> From: Pan Bian <bianpan2016@163.com>
> 
> Function devm_ioremap() will return a NULL pointer if it fails to remap
> IO address, and its return value should be validated before it is used.
> However, in function gemini_rtc_probe(), its return value is not
> checked. This may result in bad memory access bugs on future access,
> e.g. calling the function gemini_rtc_read_time().
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
>  drivers/rtc/rtc-gemini.c | 2 ++
>  1 file changed, 2 insertions(+)
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
