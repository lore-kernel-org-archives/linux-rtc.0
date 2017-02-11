Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBKWB73CAKGQEM3KWV7A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id i80si318706wmf.0.2017.02.11.15.39.22
        for <rtc-linux@googlegroups.com>;
        Sat, 11 Feb 2017 15:39:22 -0800 (PST)
Date: Sun, 12 Feb 2017 00:39:21 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Chen-Yu Tsai <wens@csie.org>, Wei Yongjun <weiyongjun1@huawei.com>,
	rtc-linux@googlegroups.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH -next] rtc: sun6i: Fix return value check in sun6i_rtc_clk_init()
Message-ID: <20170211233921.brhtcoaozzhyw2wn@piout.net>
References: <20170209001613.21665-1-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170209001613.21665-1-weiyj.lk@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 09/02/2017 at 00:16:13 +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> In case of error, the function of_io_request_and_map() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check should
> be replaced with IS_ERR().
> 
> Fixes: 847b8bf62eb4 ("rtc: sun6i: Expose the 32kHz oscillator")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/rtc/rtc-sun6i.c | 2 +-
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
