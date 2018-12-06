Return-Path: <SRS0=to0F=OP=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EA8C04EB8
	for <linux-rtc@archiver.kernel.org>; Thu,  6 Dec 2018 15:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FCAA214C1
	for <linux-rtc@archiver.kernel.org>; Thu,  6 Dec 2018 15:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FCAA214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbeLFPh2 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:37:28 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44865 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeLFPh1 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 6 Dec 2018 10:37:27 -0500
Received: by mail-ua1-f65.google.com with SMTP id d19so289898uaq.11;
        Thu, 06 Dec 2018 07:37:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UhNiIcbB5CMlPQ75/9PFbimrhk7KmxCjlNDbIEdsBIk=;
        b=RpkBrmddNr2Vcx1FYI7YKxSpcHixStGTVJYSAp/cj4GTY6wml79QETP8M2qZdedvZk
         n+odMKKylnkdFajXwkFtJDShTnCj7cwB/t5FC5A0EFFLOCI8mh2Bf/HLs+KPe8VkFrGz
         O92xorNzvmB/mBDXE3CwS6EmxnSDhTsa4faSebcXt3QAp2H0zCMFy/kDmuMkLUgWX80x
         3EJrxL3oMvX7Q/4T7YlP3SQ4mSz3I3VOYC04FtSK0U1aXtQ5EkBdRYWuSeKGYkUsAyZg
         NQPAIAO6YcRSa3eoAEVFPU/ZMXTgboL7mbSJXy8OqEYH1zrhG3yroo9F1fkUPl/TZ3k+
         tT1A==
X-Gm-Message-State: AA+aEWZdvDhVPUlTFB6Tj2KH9PSrYSUEvRI9Z8BSApL5zarCOrS7WRZB
        kTQpfAriqMup3hgxRmxphY8eq051MKtcSo05HEU=
X-Google-Smtp-Source: AFSGD/U0bXbkt7Xfi1EnTPSGHgzm2YUAGRFomZBHCGWDgkN7wSU79pQ5xckCT/NnC6I5Ulj3fce93TzKgqh/D3rCFQI=
X-Received: by 2002:ab0:7251:: with SMTP id d17mr13712806uap.0.1544110646000;
 Thu, 06 Dec 2018 07:37:26 -0800 (PST)
MIME-Version: 1.0
References: <1544086559-47141-1-git-send-email-biju.das@bp.renesas.com>
 <1544086559-47141-3-git-send-email-biju.das@bp.renesas.com>
 <CAMuHMdVv262dM8JGWN4w3h2kq4Y4ftRczn8TF-kM_fecF4GXnw@mail.gmail.com> <OSBPR01MB21039D89E5E8852574A18893B8A90@OSBPR01MB2103.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB21039D89E5E8852574A18893B8A90@OSBPR01MB2103.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 6 Dec 2018 16:37:13 +0100
Message-ID: <CAMuHMdWRz-iutKD54vtmJxnLsb3vtm1juYDw-k1+RFCNUVsjkg@mail.gmail.com>
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

On Thu, Dec 6, 2018 at 4:24 PM Biju Das <biju.das@bp.renesas.com> wrote:
> > Subject: Re: [PATCH v3 2/4] rtc: pcf85363: Add support for NXP pcf85263 rtc
> > CC nvmem maintainer
> >
> > On Thu, Dec 6, 2018 at 10:04 AM Biju Das <biju.das@bp.renesas.com> wrote:
> > > Add support for NXP pcf85263 real-time clock. pcf85263 rtc is
> > > compatible with pcf85363,except that pcf85363 has additional 64 bytes of
> > RAM.

> > > --- a/drivers/rtc/rtc-pcf85363.c
> > > +++ b/drivers/rtc/rtc-pcf85363.c
> > > @@ -120,6 +120,11 @@ struct pcf85363 {
> > >         struct regmap           *regmap;
> > >  };
> > >
> > > +struct pcf85x63_config {
> > > +       struct regmap_config regmap;
> > > +       unsigned int num_nvram;
> > > +};
> > > +
> > >  static int pcf85363_rtc_read_time(struct device *dev, struct rtc_time
> > > *tm)  {
> > >         struct pcf85363 *pcf85363 = dev_get_drvdata(dev); @@ -311,25
> > > +316,68 @@ static int pcf85363_nvram_write(void *priv, unsigned int
> > offset, void *val,
> > >                                  val, bytes);  }
> > >
> > > -static const struct regmap_config regmap_config = {
> > > -       .reg_bits = 8,
> > > -       .val_bits = 8,
> > > -       .max_register = 0x7f,
> > > +static int pcf85x63_nvram_read(void *priv, unsigned int offset, void *val,
> > > +                              size_t bytes)
> >
> > Given bytes should be 1, val should be a pointer to a single byte...
> > What if bytes == 0?
>
> I doubt we get "bytes==0" because of the checks in " drivers/nvmem/core.c"
> Function " bin_attr_nvmem_read/ bin_attr_nvmem_write".

Depends. There are other functions calling nvmem_reg_{read,write}(),
e.g. nvmem_device_{read,write}().

>
> > > +{> +       struct pcf85363 *pcf85363 = priv;
> > > +
> > > +       return regmap_read(pcf85363->regmap, CTRL_RAMBYTE, val);
> >
> > However, regmap_read() has an unsigned int output parameter!
> > So it's writing too many bytes, and only writing the actual data byte to the
> > correct address on little-endian systems.
> > Hence you need to use an intermediate variable to convert from unsigned int
> > to byte.
>
> OK. Will use an intermediate integer variable.
>
> > > +}
> > > +
> > > +static int pcf85x63_nvram_write(void *priv, unsigned int offset, void *val,
> > > +                               size_t bytes) {
> > > +       struct pcf85363 *pcf85363 = priv;
> > > +
> > > +       return regmap_write(pcf85363->regmap, CTRL_RAMBYTE,
> > > +                               *((unsigned int *)val));
> >
> > Likewise for writing.
> >
> > > +}
> >
> > BTW, while the nvmem_device_{read,write}() public API is documented, the
> > nvmem_device.reg_{read,write}() driver API isn't.
> > And the behavior might be confusing.
> >
> > E.g.
> >  * Return: length of successful bytes read on success and negative
> >  * error code on error.
> >
> > The public API seems to assume the driver API returns zero on success, and
> > replaces the zero by the number of bytes requested.
> > If the requested number of bytes is too large, a zero success would be
> > converted to a value that's larger than the actual number of bytes
> > transferred!
> > However, the driver API can return a smaller (positive) number, which
> > matches "standard" read/write() APIs.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
