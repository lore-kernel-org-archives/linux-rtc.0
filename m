Return-Path: <SRS0=dH/0=DX=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2410BC43457
	for <linux-rtc@archiver.kernel.org>; Fri, 16 Oct 2020 17:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C39A220789
	for <linux-rtc@archiver.kernel.org>; Fri, 16 Oct 2020 17:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602869027;
	bh=ppdM48me3p4AW/R1g1QJp9mgEHxG++Tv8c4IFXdKwC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M8tRCwegUi1g0cgIneqgq38+G/u6pRAtH4V5qTikH6HSvkDjvf48QrC6HvXgV6zyY
	 DXzUYcjspToBG9mEVVPLtWH5b4RaN0doNwWM7JXglT5voGnMkmiJsg0HHHZr3HxCW6
	 7l6yGK08VF8UnRsvgXr3/0/zWEWJvx4Dw9j75TyI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390226AbgJPRXo (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 16 Oct 2020 13:23:44 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38208 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390207AbgJPRXo (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 16 Oct 2020 13:23:44 -0400
Received: by mail-oi1-f196.google.com with SMTP id h10so3257777oie.5;
        Fri, 16 Oct 2020 10:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ua8FkzLPTPiTQmIFCi30OGWGpxSTgeegBJkVH2CYeUg=;
        b=lrBwoLLNz5PzMtOgTGtgwiTrLdUOJcgOFlZOKqAoyfAOZiHp8RCj3yFJDTRgIhmFgZ
         gU0khAAFGWNXUDN2L1iiaffpJ4tbyWLHnOCWWhegOlWqqiepdAzPl/Rr+LNZsbolwtHz
         P7WxwrKXS67hMIvOCyJE3OXC4Coaw/J923zsaVDcOuL14LJrEkRgzQp5k9hbKmJB8Tv1
         2QQTsaaX5BqTqIixL0tLrpvObqfrba0Hq/XALchM1I/cf06/foKDDNu+weW4vGpBrYbl
         gjVZUXu8gqaf4Kimfv9T/Id2dhKEyMy+ffbDWjLhiOwzgEE2LYlNhOmdgpM/w0N2t4SA
         S84g==
X-Gm-Message-State: AOAM531QCtIUol9Eg4G3wcUaxDwlPihcMvTcoobBd4749Co+1uFU1SKm
        X2hmwliww5vyHRKevlq7kg==
X-Google-Smtp-Source: ABdhPJw/N+caGqICZsgwqLMcqM9AmHGILM0oe+4860KsHX6WqNrMJ30UWJpKrLbijQZlE6ve8r531Q==
X-Received: by 2002:aca:5c0b:: with SMTP id q11mr3318708oib.103.1602869022044;
        Fri, 16 Oct 2020 10:23:42 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z126sm1198034oia.57.2020.10.16.10.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 10:23:41 -0700 (PDT)
Received: (nullmailer pid 1605992 invoked by uid 1000);
        Fri, 16 Oct 2020 17:23:40 -0000
Date:   Fri, 16 Oct 2020 12:23:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: rtc: rv3032: add RV-3032 bindings
Message-ID: <20201016172340.GA1605947@bogus>
References: <20201013144110.1942218-1-alexandre.belloni@bootlin.com>
 <20201013144110.1942218-2-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013144110.1942218-2-alexandre.belloni@bootlin.com>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Tue, 13 Oct 2020 16:41:09 +0200, Alexandre Belloni wrote:
> Document the Microcrystal RV-3032 device tree bindings
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
> changes in v3:
>  - remove rtc.yaml change
> 
> 
>  .../bindings/rtc/microcrystal,rv3032.yaml     | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/microcrystal,rv3032.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
