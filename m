Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4D9C2BBCD
	for <linux-rtc@archiver.kernel.org>; Wed, 16 Dec 2020 14:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F684205CB
	for <linux-rtc@archiver.kernel.org>; Wed, 16 Dec 2020 14:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgLPOE3 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 16 Dec 2020 09:04:29 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:44039 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgLPOE3 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 16 Dec 2020 09:04:29 -0500
Received: by mail-ot1-f51.google.com with SMTP id f16so22954121otl.11;
        Wed, 16 Dec 2020 06:04:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=TfpHVaBEEhYcbR1qu9fWE/7+sLFaSTXgax6byjyN7e0=;
        b=m42lOzRmjRs1k8lUIONxq/MTDWMmn35t2798U0OSt5u/UIKqPmaiBrGaVaxKF9ig5m
         XP+nYyarfrgcvTqjkDm33yaXG0FUAu2yZFGi7lgNlSP3KIJBmkGFTcGzoEUzhZE3YUAf
         I79pHlBuGP02r76HVzlCcY1cRSuP+Uo0aoId57qt5OSOz2PbkKJlrrGK6qgVmnuf4g1N
         B65lQn3Ytrh/+gKuLrcJWHUB3I+3VqgWwDD3EWF4VM93kF/mJcJL6jphS3k84+4SzYDu
         X5q8qh5PVUxmgSiwQWflp0C0LWY3yxyc59B+uGzsvAhJ58tfDHBmmsVb21bWpUgx0PVh
         tEwA==
X-Gm-Message-State: AOAM531GWmUPHPZczpOi3LB+44nqLV8vg20cR16X+JcbcwxwO46Qy/EN
        OCNXWY5GVqOEzPtYlMd06g==
X-Google-Smtp-Source: ABdhPJywCgAqv1oEd87elIYqW5iKCekTwX0/J4yFNgA4SNmfklSlJdtTRtYsMZ6wKRPTE5A55vhstQ==
X-Received: by 2002:a9d:650a:: with SMTP id i10mr14599407otl.341.1608127428406;
        Wed, 16 Dec 2020 06:03:48 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t18sm438770otc.64.2020.12.16.06.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 06:03:47 -0800 (PST)
Received: (nullmailer pid 1817444 invoked by uid 1000);
        Wed, 16 Dec 2020 14:03:46 -0000
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org,
        Yuchen Huang <yuchen.huang@mediatek.com>,
        Fei Shao <fshao@chromium.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Sean Wang <sean.wang@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>, srv_heupstream@mediatek.com,
        Ran Bi <ran.bi@mediatek.com>, Rob Herring <robh+dt@kernel.org>
In-Reply-To: <1608104827-7937-5-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1608104827-7937-1-git-send-email-hsin-hsiung.wang@mediatek.com> <1608104827-7937-5-git-send-email-hsin-hsiung.wang@mediatek.com>
Subject: Re: [PATCH v4 4/9] dt-bindings: regulator: Add document for MT6359 regulator
Date:   Wed, 16 Dec 2020 08:03:46 -0600
Message-Id: <1608127426.112276.1817443.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Wed, 16 Dec 2020 15:47:02 +0800, Hsin-Hsiung Wang wrote:
> add dt-binding document for MediaTek MT6359 PMIC
> 
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  .../bindings/regulator/mt6359-regulator.yaml  | 169 ++++++++++++++++++
>  1 file changed, 169 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mt6359-regulator.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/mt6359-regulator.yaml: 'additionalProperties' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/mt6359-regulator.yaml: ignoring, error in schema: 
warning: no schema found in file: ./Documentation/devicetree/bindings/regulator/mt6359-regulator.yaml

See https://patchwork.ozlabs.org/patch/1416913

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

