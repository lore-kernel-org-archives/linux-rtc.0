Return-Path: <SRS0=hZ7y=OJ=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797FDC04EB8
	for <linux-rtc@archiver.kernel.org>; Fri, 30 Nov 2018 12:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A4F20863
	for <linux-rtc@archiver.kernel.org>; Fri, 30 Nov 2018 12:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A4F20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbeLAACW (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:02:22 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46158 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeLAACW (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 30 Nov 2018 19:02:22 -0500
Received: by mail-vs1-f65.google.com with SMTP id r14so3231458vsc.13;
        Fri, 30 Nov 2018 04:53:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jNGKDe/ixr/ZlnlY+mP4wrAX19Ge7OU4+LccKCwlv7g=;
        b=gn7eUp+9Tn8eIZ9+m6JLaBqhijduoOJ635MT62qEQV4+30X+6i7pvnFPjAtFJSeydj
         4rxnr+IJsezPdwza2iqyEIrBdYIf9d3Ol9klvj+nPKlg5yKhNKS2p8RcCdv/nNClkFsj
         qn/oKxWt3wIicyqwdANi8vUnqdxfIkcQB9wISuPOwUIXBXH2LQsZDuATgAt4kxNXw8h+
         R2ok/v1u/jEBIs1+CRO5qEC/1Tg/ev3e0g58dW9gZL01gMMDIA6KQ77XCbcHrT5OOs1c
         0lu16sxlFl5kiYi0xHFoh3+aaZTcIKglUUW+N1Z/4hY9pXNpWdibJC4zq8Ud0T25WWDU
         k+UQ==
X-Gm-Message-State: AA+aEWaqUA3lsyMKiOCQxP2CkkfuBOTcnmq7KBdyzPPKU0jMcSbOzUBI
        kyEwnKa4kXsqHb9OMsEZ/JPCfICj0h7oj16gvkv4Qg==
X-Google-Smtp-Source: AFSGD/XGhqz5v2WVXkFujQsD2A9HLbcUhEb8zxHzS6h0zyDW7zuI1io4sEAKVUn7UQbNX/fAmOJysVbjvPAdG4yF52w=
X-Received: by 2002:a67:f43:: with SMTP id 64mr2497583vsp.166.1543582388085;
 Fri, 30 Nov 2018 04:53:08 -0800 (PST)
MIME-Version: 1.0
References: <1543510486-29532-1-git-send-email-biju.das@bp.renesas.com>
 <1543510486-29532-3-git-send-email-biju.das@bp.renesas.com>
 <CAMuHMdXmS6cCZhX_b+oszDjt+t8zgAkCGApweOX-k0Uq05=AEg@mail.gmail.com> <20181130123213.GM8952@piout.net>
In-Reply-To: <20181130123213.GM8952@piout.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 30 Nov 2018 13:52:56 +0100
Message-ID: <CAMuHMdW6=B5n8CEmqVEaqxtLD9tO3ue7_A1sTBVgi+2SPfVa8g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] rtc: pcf85363: Add support for NXP pcf85263 rtc
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Biju Das <biju.das@bp.renesas.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-rtc@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi Alexandre,

On Fri, Nov 30, 2018 at 1:32 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> On 30/11/2018 12:05:16+0100, Geert Uytterhoeven wrote:
> > On Thu, Nov 29, 2018 at 6:03 PM Biju Das <biju.das@bp.renesas.com> wrote:
> > > Add support for NXP pcf85263 real-time clock. pcf85263 rtc is compatible
> > > with pcf85363,except that pcf85363 has additional 64 bytes of RAM.
> > >
> > > 1 byte of nvmem is supported and exposed in sysfs (# is the instance
> > > number,starting with 0): /sys/bus/nvmem/devices/pcf85x63-#/nvmem
> > >
> > > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > > ---
> > >  V1-->V2 Incorporated Alexandre and Geert's review comment.
> >
> > Thanks for the update!
> >
> > > --- a/drivers/rtc/rtc-pcf85363.c
> > > +++ b/drivers/rtc/rtc-pcf85363.c
> >
> > > @@ -321,15 +344,25 @@ static int pcf85363_probe(struct i2c_client *client,
> > >                           const struct i2c_device_id *id)
> > >  {
> > >         struct pcf85363 *pcf85363;
> > > -       struct nvmem_config nvmem_cfg = {
> > > -               .name = "pcf85363-",
> > > -               .word_size = 1,
> > > -               .stride = 1,
> > > -               .size = NVRAM_SIZE,
> > > -               .reg_read = pcf85363_nvram_read,
> > > -               .reg_write = pcf85363_nvram_write,
> > > +       const struct regmap_config *regmap_config = &pcf_85363_regmap_config;
> > > +       struct nvmem_config nvmem_cfg[] = {
> >
> > static?
> >
> > Although the nvmem_config is copied, and thus static is not needed, I
> > guess using static will decrease kernel size.
> >
>
> Hum, I don't think, this is on the stack anyway.

If you make it static, it's no longer allocated on the stack, and gcc has no
longer to emit code to initialize all members.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
