Return-Path: <rtc-linux+bncBDDYJV4J2MORBR7NVCVQKGQE2M4NNFY@googlegroups.com>
Received: from mail-vn0-x230.google.com (mail-vn0-x230.google.com. [2607:f8b0:400c:c0f::230])
        by gmr-mx.google.com with ESMTPS id z9si154382vdj.0.2015.05.30.15.16.39
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 May 2015 15:16:39 -0700 (PDT)
Received: by vnbg62 with SMTP id g62so12141570vnb.8
        for <rtc-linux@googlegroups.com>; Sat, 30 May 2015 15:16:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1432730896-13423-1-git-send-email-jan.kardell@telliq.com>
References: <1432730896-13423-1-git-send-email-jan.kardell@telliq.com>
Date: Sun, 31 May 2015 00:16:39 +0200
Message-ID: <CAFLxGvzkfnLFJv+4AdsptU6+F4DMth0aa0OxBGzN8dQxau2G_Q@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v2] rtc: pcf8563 fix: return -EINVAL if we
 read an invalid time.
From: Richard Weinberger <richard.weinberger@gmail.com>
To: Jan Kardell <jan.kardell@telliq.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, rtc-linux@googlegroups.com,
	LKML <linux-kernel@vger.kernel.org>, Vincent Donnefort <vdonnefort@gmail.com>,
	Dan Carpenter <dan.carpenter@oracle.com>, oen@telliq.com
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Wed, May 27, 2015 at 2:48 PM, Jan Kardell <jan.kardell@telliq.com> wrote:
> Return -EINVAL if the voltage low bit is set to avoid getting a bogus
> time at boot.
> There was a comment stating that util-linux hwclock refuses to set a
> new time if we return an error code on read, but at least the current
> version do set the time as expected. Remove the comment and the check
> for valid time, and let the rtc core check it for us.
>
> Changes in v2: Remove the test for invalid time. Change dev_err to
> dev_info when voltage low is set.
>
> Signed-off-by: Jan Kardell <jan.kardell@telliq.com>
> ---
>  drivers/rtc/rtc-pcf8563.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
> index 0ba7e59..6ce0a86 100644
> --- a/drivers/rtc/rtc-pcf8563.c
> +++ b/drivers/rtc/rtc-pcf8563.c
> @@ -22,7 +22,7 @@
>  #include <linux/of.h>
>  #include <linux/err.h>
>
> -#define DRV_VERSION "0.4.3"
> +#define DRV_VERSION "0.4.4"

Why do you need that?
Isn't the kernel version enough? :)

-- 
Thanks,
//richard

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
