Return-Path: <SRS0=WBM2=OT=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E29C04EB8
	for <linux-rtc@archiver.kernel.org>; Mon, 10 Dec 2018 12:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1779420855
	for <linux-rtc@archiver.kernel.org>; Mon, 10 Dec 2018 12:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="TKzNY4dV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1779420855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeLJMQ1 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 10 Dec 2018 07:16:27 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:41781 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbeLJMQ1 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 10 Dec 2018 07:16:27 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id CE52D25B7A1;
        Mon, 10 Dec 2018 23:16:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1544444185; bh=Oe9bGJF7aC6g/MF/M4JwNpO50S+8+iZF/gXRnPYMbAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TKzNY4dV17zOdnpKzL2vbAaR+78hlvXuutYLLVgLVfH9zGhR38IzfYfCQKzdBVAPK
         vKYXK4UTy+L6RxNFnbUWpukCyuAlcVRuNUBCpcgc65N0jlmzJYn1lY7OiHwxLshikd
         4HXRrovcroutjcRazFxXj3Gci9PixYEFg5YzpE+I=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 5FCB49402E1; Mon, 10 Dec 2018 13:16:23 +0100 (CET)
Date:   Mon, 10 Dec 2018 13:16:23 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Biju Das <biju.das@bp.renesas.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 2/5] dt-bindings: rtc: pcf85363: Document pcf85263
 real-time clock
Message-ID: <20181210121622.zhxv35c3pqrwo43o@verge.net.au>
References: <1544182066-31528-1-git-send-email-biju.das@bp.renesas.com>
 <1544182066-31528-3-git-send-email-biju.das@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544182066-31528-3-git-send-email-biju.das@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Fri, Dec 07, 2018 at 11:27:43AM +0000, Biju Das wrote:
> The pcf85263 RTC is compatible with the pcf85363 RTC.
> 
> The difference between the pcf85263 and pcf85363 RTC is that the latter has
> 64 bytes more RAM. This renders them incompatible from a DT point of view.
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

