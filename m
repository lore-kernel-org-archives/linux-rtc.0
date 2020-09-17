Return-Path: <SRS0=2Wj4=C2=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD4AC433E2
	for <linux-rtc@archiver.kernel.org>; Thu, 17 Sep 2020 19:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36F0E206DB
	for <linux-rtc@archiver.kernel.org>; Thu, 17 Sep 2020 19:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqGdOe/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgIQT57 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 17 Sep 2020 15:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgIQT57 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 17 Sep 2020 15:57:59 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40407C061355;
        Thu, 17 Sep 2020 12:29:21 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id j2so3679052eds.9;
        Thu, 17 Sep 2020 12:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jj1NYDHlCzwQu/Kib7EFw2erEDA1Fuy+oKP7IZvnOMA=;
        b=KqGdOe/enJaOZIkuti5nTMI7rgvsIlf73k5XMbvRdt+cR9DCpA6KGv59gbaJC2YK7e
         Iq+W0RlRAc1nGYbtScmzZ4cyVS7oEiHG8x3cyFXPEZ9qNeNP9mNmGS3ftHTbW33BTmBU
         Sck+8J+YHQYgjHPkh84CQqrgmceWQ+MmpUgo+lLY3JhRymA4AxUL0rauLlpbuH5mVxi1
         MmeXfszygeeVzaMO2VcxD62LjtT9oFw4X8+e29XT1GR+RUGq1+8dSJOOqsxNogXbCtuX
         jaNRsG0jYODsCxfye5k0qyfOodg8lhfnJYX7KNOSRihMzl7BCsDGYdS3zt4aaollA9Mk
         DsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jj1NYDHlCzwQu/Kib7EFw2erEDA1Fuy+oKP7IZvnOMA=;
        b=VVg5+P//MZxAs4dnq2/tpjFqPGOzv18o5Irrwc/C+zlGb8DTYjXEI394dTYMPrrUY3
         yUdVzYBDjAYCB4goif9CAThw2jUhOtTvcoqmNjbJODXSvFGR0lw1X9f+YN+26x9iFq/e
         ilhHtcxfDq3dLyWZ2izdoZt49RMLxb5qnxJf+KQo+sEU+LDdbrmWkec7idUk7kKEuHBV
         7eAf5jzyIwpUfWVInhW2WKzFYldni/WlXtdDlpJ4j3gOYaVayF2bncHfb9dc8pFi5VSs
         Y2Y/JUJhSScMw0FiPrCweW/ut0KOgLqAWrMPr8D9s1lST+Fdj/wPVvr0s92M0PQ3WE72
         lgzw==
X-Gm-Message-State: AOAM533nvrTbG2B4V0w/SBuo832+SmwkR5shEFZ/mYQoxqrQ3Qa3hStV
        sHn/uAeV/j9acWE3TBRKSr3xtFMYDndeM2FerYU=
X-Google-Smtp-Source: ABdhPJzA3dLWUoHTqvdw58Fcn7ViL3Xce9QemwoZRQ0np0RaFSOpwhtb2LL6kwQC0qntPblEuVLPOrR5AfhwMNaQmfo=
X-Received: by 2002:aa7:d959:: with SMTP id l25mr34054370eds.383.1600370959694;
 Thu, 17 Sep 2020 12:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200827091441.12972-1-qiang.zhao@nxp.com> <20200909202456.GA3019412@bogus>
 <VE1PR04MB676899EEA79D59061FE91BF691270@VE1PR04MB6768.eurprd04.prod.outlook.com>
 <CAL_JsqJx=7npNYNe4MybNvdNRxBj_XjvEOJsSm+gNGEkvbh2VA@mail.gmail.com> <VE1PR04MB6768F9352B510CB6E873515A91230@VE1PR04MB6768.eurprd04.prod.outlook.com>
In-Reply-To: <VE1PR04MB6768F9352B510CB6E873515A91230@VE1PR04MB6768.eurprd04.prod.outlook.com>
From:   Bruno Thomsen <bruno.thomsen@gmail.com>
Date:   Thu, 17 Sep 2020 21:29:03 +0200
Message-ID: <CAH+2xPAVhivJJ4DGZ+79kyeiLN-f93xMBbMEXTVUN-rrm4hawQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: rtc-2127: Add bindings for nxp,rtc-2127.txt
To:     Qiang Zhao <qiang.zhao@nxp.com>
Cc:     Rob Herring <robh@kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Den man. 14. sep. 2020 kl. 09.08 skrev Qiang Zhao <qiang.zhao@nxp.com>:
>
> On Fri, Sep 11, 2020 at 22:03, Rob Herring <robh@kernel.org> wrote:

> Please help to review as below, if it is ok, I will send the new version patch. Thank you!
>
> diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> new file mode 100644
> index 0000000..809dd59
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/nxp,pcf2127.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PCF RTCs
> +
> +maintainers:
> +  - Qiang Zhao <qiang.zhao@nxp.com>
> +
> +allOf:
> +  - $ref: "rtc.yaml#"
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,pcf2127
> +      - nxp,pcf2129

The device driver have 3 compatible strings, "nxp,pca2129" is missing.

/Bruno

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  no-watchdog:
> +    maxItems: 1
> +
> +  start-year: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +...
>
> >
> > Documentation/devicetree/writing-schema.rst and about 1000 examples in the
> > kernel tree.
> >
> > Rob
