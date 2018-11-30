Return-Path: <SRS0=hZ7y=OJ=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480E1C04EB8
	for <linux-rtc@archiver.kernel.org>; Fri, 30 Nov 2018 12:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9DD2082F
	for <linux-rtc@archiver.kernel.org>; Fri, 30 Nov 2018 12:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D9DD2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbeK3XlZ (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 30 Nov 2018 18:41:25 -0500
Received: from mail.bootlin.com ([62.4.15.54]:51452 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbeK3XlZ (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Fri, 30 Nov 2018 18:41:25 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C4580207BC; Fri, 30 Nov 2018 13:32:13 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr [90.88.18.158])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8DF8620787;
        Fri, 30 Nov 2018 13:32:13 +0100 (CET)
Date:   Fri, 30 Nov 2018 13:32:13 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Biju Das <biju.das@bp.renesas.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-rtc@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] rtc: pcf85363: Add support for NXP pcf85263 rtc
Message-ID: <20181130123213.GM8952@piout.net>
References: <1543510486-29532-1-git-send-email-biju.das@bp.renesas.com>
 <1543510486-29532-3-git-send-email-biju.das@bp.renesas.com>
 <CAMuHMdXmS6cCZhX_b+oszDjt+t8zgAkCGApweOX-k0Uq05=AEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXmS6cCZhX_b+oszDjt+t8zgAkCGApweOX-k0Uq05=AEg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 30/11/2018 12:05:16+0100, Geert Uytterhoeven wrote:
> Hi Biju,
> 
> On Thu, Nov 29, 2018 at 6:03 PM Biju Das <biju.das@bp.renesas.com> wrote:
> > Add support for NXP pcf85263 real-time clock. pcf85263 rtc is compatible
> > with pcf85363,except that pcf85363 has additional 64 bytes of RAM.
> >
> > 1 byte of nvmem is supported and exposed in sysfs (# is the instance
> > number,starting with 0): /sys/bus/nvmem/devices/pcf85x63-#/nvmem
> >
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > ---
> >  V1-->V2 Incorporated Alexandre and Geert's review comment.
> 
> Thanks for the update!
> 
> > --- a/drivers/rtc/rtc-pcf85363.c
> > +++ b/drivers/rtc/rtc-pcf85363.c
> 
> > @@ -321,15 +344,25 @@ static int pcf85363_probe(struct i2c_client *client,
> >                           const struct i2c_device_id *id)
> >  {
> >         struct pcf85363 *pcf85363;
> > -       struct nvmem_config nvmem_cfg = {
> > -               .name = "pcf85363-",
> > -               .word_size = 1,
> > -               .stride = 1,
> > -               .size = NVRAM_SIZE,
> > -               .reg_read = pcf85363_nvram_read,
> > -               .reg_write = pcf85363_nvram_write,
> > +       const struct regmap_config *regmap_config = &pcf_85363_regmap_config;
> > +       struct nvmem_config nvmem_cfg[] = {
> 
> static?
> 
> Although the nvmem_config is copied, and thus static is not needed, I
> guess using static will decrease kernel size.
> 

Hum, I don't think, this is on the stack anyway.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
