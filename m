Return-Path: <rtc-linux+bncBDZJXP7F6YLRBRURU66QKGQERJPR6NA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr. [192.134.164.104])
        by gmr-mx.google.com with ESMTPS id j127si239313ith.0.2016.08.09.05.12.54
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Aug 2016 05:12:54 -0700 (PDT)
Date: Tue, 9 Aug 2016 14:03:35 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
cc: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
    rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
    kernel-janitors@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: pcf2123: Add missing error code
 assignment before test
In-Reply-To: <1470743907-11498-1-git-send-email-christophe.jaillet@wanadoo.fr>
Message-ID: <alpine.DEB.2.10.1608091403050.2911@hadrien>
References: <1470743907-11498-1-git-send-email-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1817157135-1470744216=:2911"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1817157135-1470744216=:2911
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 9 Aug 2016, Christophe JAILLET wrote:

> It is likely that checking the result of 'pcf2123_write_reg' is expected
> here.
> Also fix a small style issue. The '{' at the beginning of the function
> is misplaced.

They shouldn't be in the same patch.  If you are wrong about the ret
issue, the { should still be moved.

julia

>
> Fixes: 809b453b76e15 ("rtc: pcf2123: clean up writes to the rtc chip")
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/rtc/rtc-pcf2123.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/rtc/rtc-pcf2123.c b/drivers/rtc/rtc-pcf2123.c
> index b4478cc92b55..8895f77726e8 100644
> --- a/drivers/rtc/rtc-pcf2123.c
> +++ b/drivers/rtc/rtc-pcf2123.c
> @@ -182,7 +182,8 @@ static ssize_t pcf2123_show(struct device *dev, struct device_attribute *attr,
>  }
>
>  static ssize_t pcf2123_store(struct device *dev, struct device_attribute *attr,
> -			     const char *buffer, size_t count) {
> +			     const char *buffer, size_t count)
> +{
>  	struct pcf2123_sysfs_reg *r;
>  	unsigned long reg;
>  	unsigned long val;
> @@ -199,7 +200,7 @@ static ssize_t pcf2123_store(struct device *dev, struct device_attribute *attr,
>  	if (ret)
>  		return ret;
>
> -	pcf2123_write_reg(dev, reg, val);
> +	ret = pcf2123_write_reg(dev, reg, val);
>  	if (ret < 0)
>  		return -EIO;
>  	return count;
> --
> 2.7.4
>
>
> ---
> L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
> https://www.avast.com/antivirus
>
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--8323329-1817157135-1470744216=:2911--
