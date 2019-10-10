Return-Path: <SRS0=m+Hu=YD=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF94C4360C
	for <linux-rtc@archiver.kernel.org>; Thu, 10 Oct 2019 21:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D4520B7C
	for <linux-rtc@archiver.kernel.org>; Thu, 10 Oct 2019 21:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570743612;
	bh=S8nZlTAh5Sa2NZKROt6OdVk3cK/cgQ1Bfz4vl7P5Akg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LiItx5IFLdmzzwbTCYKR6GALoEFfLSk5ocpJI4o/dhYWouLjgA/WVKzS0I1zePl7e
	 lHxluCQaTgX9Ggm1SITHGlcy4JTmY77CmtMnFcOO43VsCSR/H7SalQtbZ3RFZfziXd
	 qdN9Esz7HgZ4V8j6mbc1E0X/2Yrff9k/8YlUgmYo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfJJVkM (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 10 Oct 2019 17:40:12 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:32827 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJVkM (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 10 Oct 2019 17:40:12 -0400
Received: by mail-ot1-f65.google.com with SMTP id 60so6237523otu.0;
        Thu, 10 Oct 2019 14:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OhBmb9lod5Y57x5hzCm24bUq/WGP4qSxDISKT1yzR6Q=;
        b=heOtNVXq48eqzEIAGObMX84V+tP1s8TAoqrTc7PyrWYy4R0eGczIEoFptgNf7Uml0C
         z8nskw0PRyzMejEoTPyrI70/eJff4JUkQUeaAidYKJfNgTABS3jn+QVoEV29r+LzN256
         5/88lYfGoaTDVoI3CLByHCIiQxvh9u9+mZ9NS/HA1soXcFH2fIkGdlSQ0CLAUD83W5fb
         ON0ZqpitLgyV62sYx8RGEexOOOynrDaa8GWer0bq/DUEBit0wJZXYBXA4E3edXmqWlGV
         CFAIUhb+1T+3wmLhshNpSNxO7M3JhHADFd0ii1C/cwKfwqULl+qPDGD9ShYFpCCjDRII
         yWdg==
X-Gm-Message-State: APjAAAU16kyF1UkJ0bkKvPxBJJmsgEe3unG0r06NiofK/iYuZDRrmklQ
        NNklz08uwaOaD3vWm7cl8P+753Q=
X-Google-Smtp-Source: APXvYqz/xLLLoYlYKuqeF5HS+9KV3dUn7CVP1+Pcqsf9s366MQnZGaFwgYQxrsbuODkR3pUz3ATndQ==
X-Received: by 2002:a05:6830:14c9:: with SMTP id t9mr8372392otq.133.1570743610981;
        Thu, 10 Oct 2019 14:40:10 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l81sm2025740oih.10.2019.10.10.14.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 14:40:10 -0700 (PDT)
Date:   Thu, 10 Oct 2019 16:40:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Simon Horman <horms+renesas@verge.net.au>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Brandt <chris.brandt@renesas.com>,
        Yoshihiro Kaneko <ykaneko0929@gmail.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms+renesas@verge.net.au>
Subject: Re: [PATCH v2] dt-bindings: rtc: rtc-sh: convert bindings to
 json-schema
Message-ID: <20191010214009.GA4348@bogus>
References: <20190923121404.32585-1-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923121404.32585-1-horms+renesas@verge.net.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Mon, 23 Sep 2019 14:14:04 +0200, Simon Horman wrote:
> Convert Real Time Clock for Renesas SH and ARM SoCs bindings documentation
> to json-schema.  Also name bindings documentation file according to the
> compat string being documented.
> 
> Also correct syntax error in interrupts field in example.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
> ---
> v2
> * Added reviewed-by tag from Ulrich
> * Constrain clocks and clock-names as suggested by Rob Herring
> ---
>  .../devicetree/bindings/rtc/renesas,sh-rtc.yaml    | 70 ++++++++++++++++++++++
>  Documentation/devicetree/bindings/rtc/rtc-sh.txt   | 28 ---------
>  2 files changed, 70 insertions(+), 28 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/rtc/renesas,sh-rtc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-sh.txt
> 

Applied, thanks.

Rob
