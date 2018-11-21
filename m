Return-Path: <SRS0=N1Xq=OA=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A882DC43441
	for <linux-rtc@archiver.kernel.org>; Wed, 21 Nov 2018 10:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E40B21104
	for <linux-rtc@archiver.kernel.org>; Wed, 21 Nov 2018 10:35:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E40B21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbeKUVJW (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 21 Nov 2018 16:09:22 -0500
Received: from mail.bootlin.com ([62.4.15.54]:42849 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbeKUVJW (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 21 Nov 2018 16:09:22 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1351A20D29; Wed, 21 Nov 2018 11:35:28 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id D282C20701;
        Wed, 21 Nov 2018 11:35:17 +0100 (CET)
Date:   Wed, 21 Nov 2018 11:35:17 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Biju Das <biju.das@bp.renesas.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 2/4] rtc: pcf85363: Add support for NXP pcf85263 rtc
Message-ID: <20181121103517.GJ8367@piout.net>
References: <1542626108-61344-1-git-send-email-biju.das@bp.renesas.com>
 <1542626108-61344-3-git-send-email-biju.das@bp.renesas.com>
 <CAMuHMdVpaB0mJq9LmBoHgBY9MNAXYAKN=h8hCX+iph+D_5pY=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVpaB0mJq9LmBoHgBY9MNAXYAKN=h8hCX+iph+D_5pY=Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 21/11/2018 11:23:08+0100, Geert Uytterhoeven wrote:
> Hi Biju,
> 
> On Mon, Nov 19, 2018 at 12:23 PM Biju Das <biju.das@bp.renesas.com> wrote:
> > Add support for NXP pcf85263 real-time clock. pcf85263 rtc is compatible
> > with pcf85363,except that pcf85363 has additional 64 bytes of RAM.
> >
> > 1 byte of nvmem is supported and exposed in sysfs (# is the instance
> > number,starting with 0): /sys/bus/nvmem/devices/pcf85263-#/nvmem
> >
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> 
> Thanks for your patch!
> 
> > --- a/drivers/rtc/rtc-pcf85363.c
> > +++ b/drivers/rtc/rtc-pcf85363.c
> > @@ -311,7 +311,30 @@ static int pcf85363_nvram_write(void *priv, unsigned int offset, void *val,
> >                                  val, bytes);
> >  }
> >
> > -static const struct regmap_config regmap_config = {
> > +static int pcf85263_nvram_read(void *priv, unsigned int offset, void *val,
> > +                              size_t bytes)
> > +{
> > +       struct pcf85363 *pcf85363 = priv;
> > +
> > +       return regmap_read(pcf85363->regmap, CTRL_RAMBYTE, val);
> > +}
> 
> AFAIU without reading the datasheet, the pcf85363 also has this RAMBYTE
> register. Would it make sense to expose the contents on both parts?
> 

Yes it has. This series allows calling rtc_nvmem_register() multiple
times from the same driver:

http://patchwork.ozlabs.org/project/rtc-linux/list/?series=75212


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
