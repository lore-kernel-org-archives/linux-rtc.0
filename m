Return-Path: <SRS0=WBM2=OT=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE13BC04EB8
	for <linux-rtc@archiver.kernel.org>; Mon, 10 Dec 2018 13:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B387020821
	for <linux-rtc@archiver.kernel.org>; Mon, 10 Dec 2018 13:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="DqsDJYWW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B387020821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeLJNWb (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:22:31 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:42735 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLJNWb (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 10 Dec 2018 08:22:31 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 2F9FE25B73F;
        Tue, 11 Dec 2018 00:22:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1544448149; bh=wKrnhrTitCSOZm36DG3ToIrfZAuKKgrjPx5U6aDpugs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DqsDJYWWmBoBYCh7zIrdoRZV2ikiHYvp8bb1NlT9MpnT0iK0Jg0KZUlFmZpxupEJN
         UhBzR7scfWlqBObsd5iKpi7HtHEIYR1RZCyyVnZ7z9HBR9Lij+PEohvf0syYfU/N+3
         Dd81D1p//DsTEz4hccDKf/4utXEaVB0aY/XULWF0=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 33BDC9402E1; Mon, 10 Dec 2018 14:22:27 +0100 (CET)
Date:   Mon, 10 Dec 2018 14:22:27 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Biju Das <biju.das@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: Re: [PATCH v4 4/5] ARM: shmobile: Enable NXP pcf85363 rtc in
 shmobile_defconfig
Message-ID: <20181210132226.ppn74nzto6bv3mm3@verge.net.au>
References: <1544182066-31528-1-git-send-email-biju.das@bp.renesas.com>
 <1544182066-31528-5-git-send-email-biju.das@bp.renesas.com>
 <20181210121340.iuwyq5myk4woezpg@verge.net.au>
 <OSBPR01MB2103861EF91EE6456EB3E03BB8A50@OSBPR01MB2103.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB2103861EF91EE6456EB3E03BB8A50@OSBPR01MB2103.jpnprd01.prod.outlook.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Mon, Dec 10, 2018 at 12:35:35PM +0000, Biju Das wrote:
> Hi Simon,
> 
> Thanks for the feedback.
> 
> > Subject: Re: [PATCH v4 4/5] ARM: shmobile: Enable NXP pcf85363 rtc in
> > shmobile_defconfig
> >
> > On Fri, Dec 07, 2018 at 11:27:45AM +0000, Biju Das wrote:
> > > The iWave RZ/G1C SBC supports RTC (NXP pcf85263). To increase hardware
> > > support enable the driver in the shmobile_defconfig multiplatform
> > > configuration.
> > >
> > > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > Thanks, applied for v4.22.
> >
> > Is a similar change for multi_v7_defconfig also appropriate?
> 
> Will send a separate patch for adding it to the "multi_v7_defconfig"
> 
> CONFIG_RTC_DRV_PCF85363=m

Great, thanks.
