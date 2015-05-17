Return-Path: <rtc-linux+bncBCGLJQVNREJBBLXC4GVAKGQEWAKTQ6A@googlegroups.com>
Received: from mailgw01.mediatek.com ([210.61.82.183])
        by gmr-mx.google.com with ESMTPS id x3si728860pdh.2.2015.05.17.03.45.01
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 17 May 2015 03:45:02 -0700 (PDT)
Message-ID: <1431859498.31486.1.camel@mtksdaap41>
Subject: [rtc-linux] Re: [PATCH] rtc: mt6397: fix build on some 32bits platforms
From: Eddie Huang <eddie.huang@mediatek.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: <linux-mediatek@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <rtc-linux@googlegroups.com>,
	<linux-kernel@vger.kernel.org>
Date: Sun, 17 May 2015 18:44:58 +0800
In-Reply-To: <1431636678-29525-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1431636678-29525-1-git-send-email-alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Thu, 2015-05-14 at 22:51 +0200, Alexandre Belloni wrote:
> On some !ARM 32bits platforms, the following compilation error happens
> because of the division on a 64bits value in mtk_rtc_read_time():
> 
> drivers/built-in.o: In function `mtk_rtc_read_time':
> rtc-mt6397.c:(.text+0x265d13f): undefined reference to `__divdi3'
> rtc-mt6397.c:(.text+0x265d150): undefined reference to `__moddi3'
> 
> Use div_s64() as done in rtc_time64_to_tm() to solve that.
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/rtc/rtc-mt6397.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
> index 8bed852e4961..c0090b698ff3 100644
> --- a/drivers/rtc/rtc-mt6397.c
> +++ b/drivers/rtc/rtc-mt6397.c
> @@ -150,7 +150,7 @@ static int mtk_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  {
>  	time64_t time;
>  	struct mt6397_rtc *rtc = dev_get_drvdata(dev);
> -	int sec, ret;
> +	int days, sec, ret;
>  
>  	do {
>  		ret = __mtk_rtc_read_time(rtc, tm, &sec);
> @@ -171,7 +171,8 @@ static int mtk_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  	/* rtc_tm_to_time64 covert Gregorian date to seconds since
>  	 * 01-01-1970 00:00:00, and this date is Thursday.
>  	 */
> -	tm->tm_wday = (time / 86400 + 4) % 7;
> +	days = div_s64(time, 86400);
> +	tm->tm_wday = (days + 4) % 7;
>  
>  exit:
>  	return ret;

Acked-by: Eddie Huang <eddie.huang@mediatek.com>



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
