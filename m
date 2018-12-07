Return-Path: <SRS0=ySH3=OQ=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745ABC07E85
	for <linux-rtc@archiver.kernel.org>; Fri,  7 Dec 2018 23:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EDE20838
	for <linux-rtc@archiver.kernel.org>; Fri,  7 Dec 2018 23:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544224761;
	bh=DKyBMtHgH4RkLeXZbPw3OU6Yzi7Fli9fVJxfoq7XMyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oSVy5ZEcVyXf/znH3PdwNjD0M1gT7yPpnl+mY1ogin3iiXU/hNlK/v2NRNR+XubUw
	 kYaj07FIgNanc1v6H59cnLmb1qUKoJ1CAs75B5PkkGDQjA8Ait0kR9O/TnQ93PQLo5
	 tyBK8rs8TW4r+mUiiND13B9FS+MYW6W9aOlpXxDc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34EDE20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbeLGXTU (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 7 Dec 2018 18:19:20 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38596 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbeLGXTU (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 7 Dec 2018 18:19:20 -0500
Received: by mail-oi1-f195.google.com with SMTP id a77so4729455oii.5;
        Fri, 07 Dec 2018 15:19:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HNfRJAiRFxc1P8MQJ87MfpT7Sb6SzhIGgf2ybqBUVlA=;
        b=hlNdnPGpmyfybxXowJotmQJfPa4RcC+Vb+86Muia/VjQWEhp7eWI3584KEsCOa9CA9
         sxX8nFXiMA3V++YlADwQWjkT2CVITGQYjtIga/TLdpnts4pw/yUeP1vc0W33SVioWpAd
         u8L9T+tUBXYy1YErsszvVVr0b6+yXFPmSuMmQMRU9d8BUqf+82/mVWYMNPULtiDPRbUV
         RBc1WHk0HHURs9TMKomGnYlVRLTIH8yWzVMEe9PcxWXTNxtaQpAxn5Gf0kg07UXF0G1Y
         7+dZn6MVHHiYRVOy87uYjQwTw8diqb4mwQ3vmRwtzhB5TWSwRp94qRe98Eu0PNpFsmEM
         OdXQ==
X-Gm-Message-State: AA+aEWbyLRXcE93ZDK7sj225yYdtO1XlyFLmLX6D9f5Q4anSMFyuGbsv
        n2L936MQUi5ulMaQxJMbRg==
X-Google-Smtp-Source: AFSGD/Vioncqm3R7P+ZYJm69rjshXtzK+/j9ZUnGRG/GgrCbVoeEE1Zvyo7vAB7+khj6rJbVNRZK9w==
X-Received: by 2002:aca:c46:: with SMTP id i6mr2316045oiy.208.1544224759778;
        Fri, 07 Dec 2018 15:19:19 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j11sm2084480oif.9.2018.12.07.15.19.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 15:19:19 -0800 (PST)
Date:   Fri, 7 Dec 2018 17:19:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Biju Das <biju.das@bp.renesas.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Rutland <mark.rutland@arm.com>,
        Biju Das <biju.das@bp.renesas.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 2/5] dt-bindings: rtc: pcf85363: Document pcf85263
 real-time clock
Message-ID: <20181207231918.GA18691@bogus>
References: <1544182066-31528-1-git-send-email-biju.das@bp.renesas.com>
 <1544182066-31528-3-git-send-email-biju.das@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544182066-31528-3-git-send-email-biju.das@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Fri,  7 Dec 2018 11:27:43 +0000, Biju Das wrote:
> The pcf85263 RTC is compatible with the pcf85363 RTC.
> 
> The difference between the pcf85263 and pcf85363 RTC is that the latter has
> 64 bytes more RAM. This renders them incompatible from a DT point of view.
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> V1-->V2
> 	* Incorporated Simon's review comment.
> V2-->V3
> 	* No Change.
> V3-->V4
> 	* No Change.
> ---
>  Documentation/devicetree/bindings/rtc/pcf85363.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
