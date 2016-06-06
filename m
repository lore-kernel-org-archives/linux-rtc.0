Return-Path: <rtc-linux+bncBDYNJBOFRECBBWPU2S5AKGQE55XW22Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-io0-x230.google.com (mail-io0-x230.google.com. [2607:f8b0:4001:c06::230])
        by gmr-mx.google.com with ESMTPS id b6si603527ith.0.2016.06.06.01.54.48
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jun 2016 01:54:48 -0700 (PDT)
Received: by mail-io0-x230.google.com with SMTP id o189so122486057ioe.2
        for <rtc-linux@googlegroups.com>; Mon, 06 Jun 2016 01:54:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1465119356-129799-1-git-send-email-agraf@suse.de>
References: <1465119356-129799-1-git-send-email-agraf@suse.de>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 6 Jun 2016 10:54:48 +0200
Message-ID: <CAKv+Gu9cHvOBo_4Bq_rj6wqo61w=RtsL=+cRcAek7XkH5Wf+Hw@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH] rtc: efi: Fail probing if RTC reads don't work
To: Alexander Graf <agraf@suse.de>
Cc: rtc-linux@googlegroups.com, Leif Lindholm <leif.lindholm@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 5 June 2016 at 11:35, Alexander Graf <agraf@suse.de> wrote:
> While the EFI spec mandates an RTC, not every implementation actually adheres
> to that rule (or can adhere to it - some systems just don't have an RTC).
>
> For those, we really don't want to probe the EFI RTC driver at all, because if
> we do we'd get a non-functional driver that does nothing useful but only spills
> our kernel log with warnings.
>
> Signed-off-by: Alexander Graf <agraf@suse.de>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  drivers/rtc/rtc-efi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
> index 96d3860..0130afd 100644
> --- a/drivers/rtc/rtc-efi.c
> +++ b/drivers/rtc/rtc-efi.c
> @@ -259,6 +259,12 @@ static const struct rtc_class_ops efi_rtc_ops = {
>  static int __init efi_rtc_probe(struct platform_device *dev)
>  {
>         struct rtc_device *rtc;
> +       efi_time_t eft;
> +       efi_time_cap_t cap;
> +
> +       /* First check if the RTC is usable */
> +       if (efi.get_time(&eft, &cap) != EFI_SUCCESS)
> +               return -ENODEV;
>
>         rtc = devm_rtc_device_register(&dev->dev, "rtc-efi", &efi_rtc_ops,
>                                         THIS_MODULE);
> --
> 1.8.5.6
>

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
