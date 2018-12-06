Return-Path: <SRS0=to0F=OP=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40536C04EBF
	for <linux-rtc@archiver.kernel.org>; Thu,  6 Dec 2018 09:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052B720892
	for <linux-rtc@archiver.kernel.org>; Thu,  6 Dec 2018 09:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 052B720892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbeLFJj1 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:39:27 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:41003 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFJj0 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 6 Dec 2018 04:39:26 -0500
Received: by mail-vk1-f196.google.com with SMTP id t127so5343508vke.8;
        Thu, 06 Dec 2018 01:39:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xe1CR9kacczsNl4YZhjn7vPsSKrJDhlA+jdNwa7xW3c=;
        b=po7UFmv0Om2jU6iJj86U1ThKLi0X/2Jc8FelvCszfw2gNBUOtZXJ9hKZXjxI1wCr/a
         bztFRCILROnOBSfSDtQuPzvtaR6dg0VFpWhgwpIUCCvYNilR3Utzpvxs+ZK3oXMlVyJc
         Sm7QHWQO0keSTh1G1qR9MngWgsccJ5ro0dD+IsRx8jG0qY9nJ9cHrWR56a90IEWW4rtu
         1cs+szI+gOWLqoowpLtmcVUhR9fjAUWaErz2gvxPv10gyhEPlZ4SJCuuk9iMTbLC4UUw
         JmiBZC7WpFAgi7Y/GD3bW8AtMf4jnMU/8ABPls9nmzZXwXb2nSRdO5OlBJ0Ioxb0sF+T
         4Tyw==
X-Gm-Message-State: AA+aEWabiz++LtfRcVc7s2ndmDZ6KlXr96rJ+2uhlxw8oVJPdfmsBLjp
        3DwpaL/Jqa611U7CdkYN5KqkNweqWLh1COCRukc=
X-Google-Smtp-Source: AFSGD/Xch5h9wmTcufIL7S/KbwFAfOBighAPCej66puOTh1Cf/lSrUNwPv2jf+IG/sbTVMKbDVml199RzuY+WQwZuL0=
X-Received: by 2002:a1f:2145:: with SMTP id h66mr12427520vkh.65.1544089165425;
 Thu, 06 Dec 2018 01:39:25 -0800 (PST)
MIME-Version: 1.0
References: <1544086559-47141-1-git-send-email-biju.das@bp.renesas.com> <1544086559-47141-3-git-send-email-biju.das@bp.renesas.com>
In-Reply-To: <1544086559-47141-3-git-send-email-biju.das@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 6 Dec 2018 10:39:13 +0100
Message-ID: <CAMuHMdVv262dM8JGWN4w3h2kq4Y4ftRczn8TF-kM_fecF4GXnw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] rtc: pcf85363: Add support for NXP pcf85263 rtc
To:     Biju Das <biju.das@bp.renesas.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi Biju,

CC nvmem maintainer

On Thu, Dec 6, 2018 at 10:04 AM Biju Das <biju.das@bp.renesas.com> wrote:
> Add support for NXP pcf85263 real-time clock. pcf85263 rtc is compatible
> with pcf85363,except that pcf85363 has additional 64 bytes of RAM.
>
> 1 byte of nvmem is supported and exposed in sysfs (# is the instance
> number,starting with 0): /sys/bus/nvmem/devices/pcf85x63-#/nvmem
>
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> ---
> V1-->V2
>         * Incorporated Alexandre and Geert's review comment.
> V2-->V3
>         * Incorporated Geert's review comment.

Thanks for the update!

> --- a/drivers/rtc/rtc-pcf85363.c
> +++ b/drivers/rtc/rtc-pcf85363.c
> @@ -120,6 +120,11 @@ struct pcf85363 {
>         struct regmap           *regmap;
>  };
>
> +struct pcf85x63_config {
> +       struct regmap_config regmap;
> +       unsigned int num_nvram;
> +};
> +
>  static int pcf85363_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  {
>         struct pcf85363 *pcf85363 = dev_get_drvdata(dev);
> @@ -311,25 +316,68 @@ static int pcf85363_nvram_write(void *priv, unsigned int offset, void *val,
>                                  val, bytes);
>  }
>
> -static const struct regmap_config regmap_config = {
> -       .reg_bits = 8,
> -       .val_bits = 8,
> -       .max_register = 0x7f,
> +static int pcf85x63_nvram_read(void *priv, unsigned int offset, void *val,
> +                              size_t bytes)

Given bytes should be 1, val should be a pointer to a single byte...
What if bytes == 0?

> +{> +       struct pcf85363 *pcf85363 = priv;
> +
> +       return regmap_read(pcf85363->regmap, CTRL_RAMBYTE, val);

However, regmap_read() has an unsigned int output parameter!
So it's writing too many bytes, and only writing the actual data byte to the
correct address on little-endian systems.
Hence you need to use an intermediate variable to convert from unsigned
int to byte.

> +}
> +
> +static int pcf85x63_nvram_write(void *priv, unsigned int offset, void *val,
> +                               size_t bytes)
> +{
> +       struct pcf85363 *pcf85363 = priv;
> +
> +       return regmap_write(pcf85363->regmap, CTRL_RAMBYTE,
> +                               *((unsigned int *)val));

Likewise for writing.

> +}

BTW, while the nvmem_device_{read,write}() public API is documented, the
nvmem_device.reg_{read,write}() driver API isn't.
And the behavior might be confusing.

E.g.
 * Return: length of successful bytes read on success and negative
 * error code on error.

The public API seems to assume the driver API returns zero on success,
and replaces the zero by the number of bytes requested.
If the requested number of bytes is too large, a zero success would be
converted to a value that's larger than the actual number of bytes
transferred!
However, the driver API can return a smaller (positive) number, which matches
"standard" read/write() APIs.

> +static const struct pcf85x63_config pcf_85263_config = {
> +       {
> +               .reg_bits = 8,
> +               .val_bits = 8,
> +               .max_register = 0x2f,
> +       },
> +       1

The "1" looks funny. Please use C99 initializers for all struct members.

> +};
> +
> +static const struct pcf85x63_config pcf_85363_config = {
> +       {
> +               .reg_bits = 8,
> +               .val_bits = 8,
> +               .max_register = 0x7f,
> +       },
> +       2

Likewise.

The rest looks good to me, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
