Return-Path: <SRS0=5rMO=SE=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB06C43381
	for <linux-rtc@archiver.kernel.org>; Tue,  2 Apr 2019 07:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E190206BA
	for <linux-rtc@archiver.kernel.org>; Tue,  2 Apr 2019 07:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XqahE8ek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbfDBHAQ (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 2 Apr 2019 03:00:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38050 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfDBHAP (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 2 Apr 2019 03:00:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id j26so6063735pgl.5
        for <linux-rtc@vger.kernel.org>; Tue, 02 Apr 2019 00:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lG7q6x9bOATHtEAjfI+YGWaPNzgsxOn7kFCqmU7RA24=;
        b=XqahE8ekqUVFS4tzTGLzmL74ptchRVDTW9nkVV58ffVsP9BKCdg2INqdSOiiC9SjQD
         A1ugBwXu2E6MCucD4mUzKUFkzggMLo/BYZviJ+KD2XdmcDj5nFz933zBh9iicsR6O6rq
         Hz+9Vs3b/KmqdrWV1KWmYVwkCw9QsK/h/6D5Lv+M7DS0OgHWNupLDH9hNhvZMd1eNkK8
         xoVPrcceQ25WBMu0My92CJCK3O5h3z9zJhCIfs0CgluUkNlzi6vpYOFNYnNzhxb1ji9c
         3RvIDBZ3rWmNLAxnYcail7f+tn0CYOhEXpEqp0A52FZ/9z8rPUwf1um9LGF9CYnHyUR0
         w9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lG7q6x9bOATHtEAjfI+YGWaPNzgsxOn7kFCqmU7RA24=;
        b=ZD4jaGTdO1Ij9HUaYHlceosAZiu4ksSf0J6X2AVT8ByeFvT/bVqz5j8lt2UN+3M8su
         I9sG1j8TEJxcEzs2W26qx6380VkjoP+lxgZ8v6ZJ0Vi+cWsAV2gLUvyu5MAz9cq3fUxh
         acblSv/rArLmwi6lYvSF0hkjD++LfQj+Kf96hDUFsZSldFO51p4xVVnYB/ZNCA7mTRFX
         Qv05JlJi0k7gpZbourIVgv3/WgiP8hIrtSAJree3+2gYrfGPtmzoAEby6ifKW/pP+WWP
         pOzfW1PhRRIbM/XWBcg0ceOIJPrQynNOAMiEciREVLuk0d5FmkQnc3uz5CcVfFDMh5dF
         Ax6w==
X-Gm-Message-State: APjAAAWXGBuMSWr7QW5Nos9e4FbYbrThiW2RCynsUftdkeDWPNqkEs7M
        fhk8LJboWj9bqL+a/kkxMPF67g==
X-Google-Smtp-Source: APXvYqzTFEZ6Qlqz/GH8bk2tKD5L8rc0DmuRjI2qt8hubuCpxemLu19AP3S4u4E8ZhDqCUEBxfo5BQ==
X-Received: by 2002:aa7:8c84:: with SMTP id p4mr28442799pfd.164.1554188415241;
        Tue, 02 Apr 2019 00:00:15 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id v188sm17945692pgb.7.2019.04.02.00.00.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 00:00:14 -0700 (PDT)
Date:   Tue, 2 Apr 2019 08:00:07 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 3/9] dt-bindings: mfd: Add compatible for the MediaTek
 MT6358 PMIC
Message-ID: <20190402070007.GC4187@dell>
References: <1552275991-34648-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1552275991-34648-4-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1552275991-34648-4-git-send-email-hsin-hsiung.wang@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Mon, 11 Mar 2019, Hsin-Hsiung Wang wrote:

> This adds compatible for the MediaTek MT6358 PMIC.
> 
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
