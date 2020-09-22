Return-Path: <SRS0=8LRx=C7=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01677C4346E
	for <linux-rtc@archiver.kernel.org>; Tue, 22 Sep 2020 03:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA112239D4
	for <linux-rtc@archiver.kernel.org>; Tue, 22 Sep 2020 03:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600743738;
	bh=iSsbqsE+K08ClzQ23JTW3tOKG+dOLxF59xwrecN2L0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ed6tBLlMnuZCOP9HB6RWgfAIzm3qqDqrmv/A+iDDF2NnbYaB//2PY1V1EiXMlEVGn
	 1QFGi52DHQsEJEgXMFQ3+1zPIjptDQuB+jWqsL/EiqU3BpDGrs98qlLPmlyRC32YaC
	 wOBKLaKav/hekKEfI6OkpFm1/BrtKdcKy6RKzEaw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgIVDCP (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 21 Sep 2020 23:02:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:32846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgIVDCP (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 21 Sep 2020 23:02:15 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7702239D4;
        Tue, 22 Sep 2020 03:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600743734;
        bh=iSsbqsE+K08ClzQ23JTW3tOKG+dOLxF59xwrecN2L0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b0MSu19ywyBkA13I5FwiMk4wxPb4y1r2mkPorEJF9+xc5MDdnQ5R/EB6DloUO4/dY
         7zmi8WFfDgiWfyb+yh/xKgF4+5RwiSkgaqqof3K5oZRtEDHbbBK2GnFLso+IWYFCSh
         9USx1VUbdGX90mmG1ZZxVrn6lp8OP6XTxsOKIRtY=
Date:   Tue, 22 Sep 2020 11:02:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Biwen Li <biwen.li@oss.nxp.com>
Cc:     alexandre.belloni@bootlin.com, leoyang.li@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, linux-rtc@vger.kernel.org,
        Biwen Li <biwen.li@nxp.com>
Subject: Re: [PATCH 2/5] arm64: dts: lx2160a-rdb: remove useless property of
 rtc
Message-ID: <20200922030208.GY25109@dragon>
References: <20200915073213.12779-1-biwen.li@oss.nxp.com>
 <20200915073213.12779-2-biwen.li@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915073213.12779-2-biwen.li@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Tue, Sep 15, 2020 at 03:32:10PM +0800, Biwen Li wrote:
> From: Biwen Li <biwen.li@nxp.com>
> 
> Remove useless property interrupts of rtc
> 
> Signed-off-by: Biwen Li <biwen.li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> index dce79018d397..e9e982176e07 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> @@ -171,8 +171,6 @@
>  	rtc@51 {
>  		compatible = "nxp,pcf2129";
>  		reg = <0x51>;
> -		// IRQ10_B
> -		interrupts = <0 150 0x4>;

If it's a correct description of hardware, I do not see why we would
need to remove it.

Shawn

>  	};
>  };
>  
> -- 
> 2.17.1
> 
