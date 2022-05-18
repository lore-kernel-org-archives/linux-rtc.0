Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7C4C433EF
	for <linux-rtc@archiver.kernel.org>; Wed, 18 May 2022 03:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbiERDMR (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 17 May 2022 23:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbiERDMQ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 17 May 2022 23:12:16 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C109F3616A;
        Tue, 17 May 2022 20:12:13 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id g16so991530lja.3;
        Tue, 17 May 2022 20:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=02vSp6NL2SEFHRlZSj840ZFcHVEZ1KrRcvY0n91ShFQ=;
        b=iboxFKfCF5Ftyceu2NQ66HFTJR5fg3z6/0iPDLQkcD+9uO/JQ0Ggqbd6AOnqK45bvQ
         UQuLwZgUBuo28+8Upp/4mq9iSZgGmh9aQRHt28VfuDVXoDoBUeA0G790Q5/nWgefBRa2
         Q1gESIDcXUEn6wdx39uqJok/F4M/SB/7+c5gHf+iV1HWiINAXyPQBDHDAigps9PTMjFK
         yiQNE5m+hGCd2uHEXqJNKwL4nyEvY0EMVKgziP55kA/B9OdFWaCn41aJgli8E24So0Rv
         HZDPQkmZqhZ6eNfv1OHly+KvrO0stTGmQC8rq/V4HNkTHYSygEDXnZJrhkPUBH0cbeWl
         n9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=02vSp6NL2SEFHRlZSj840ZFcHVEZ1KrRcvY0n91ShFQ=;
        b=vRPWfWymbK173Dg61nmiEgDwaFYN0rG7nnv/wL1HKS3bITD5xXuytkg/LvXgBmwM4o
         UfZd3QkrW4bfcTYEF8692QCaEqs90m3CHztr4Y/6TM023FwIF4JaCdypiYKisMz3PQCJ
         lF/6/4ha84VR4GLQI4hVGBc0oVRIXRAXS4jhTCRZrpTkkJQ1gwS3IC06asWeJv/GM+Qn
         vPF31KZ1VuQ0w6LUCnRWDIe8m+r/ZdK4t9VPjJObYKtXYXqPZOHq++AUk32YSxXhFbhR
         9iB/2JrHG7VXUjRSOAITA8XtHxoo2VagxovO6LyFy84TI6c6CXHowG1NEicLZ5F/vSsw
         Ldmg==
X-Gm-Message-State: AOAM530rL2YcixBi9j4FAHkDk43PUnSlYUqPhCs8tuJYtJaXUTJUeHGa
        olw7Otcq2o9c0jqI/gAvBwaFT9iKHdMlvuknUaE=
X-Google-Smtp-Source: ABdhPJz+aavAXT6ew/Ozo72g2q2TnKFEa4u17xHcKM1USiFhdTE0QY0ypxx1CpJ0wW8tzftLSr1fRdI9BGzrqyaVDxI=
X-Received: by 2002:a2e:a801:0:b0:24a:ff0b:ae7a with SMTP id
 l1-20020a2ea801000000b0024aff0bae7amr15302657ljq.287.1652843531581; Tue, 17
 May 2022 20:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220517092927.19537-1-ctcchien@nuvoton.com> <20220517092927.19537-3-ctcchien@nuvoton.com>
 <20220518011937.GA2012974-robh@kernel.org>
In-Reply-To: <20220518011937.GA2012974-robh@kernel.org>
From:   Medad Young <medadyoung@gmail.com>
Date:   Wed, 18 May 2022 11:12:01 +0800
Message-ID: <CAHpyw9f-hinoQFxvEO6WaRnuWFsbfa97JWi0BY4joEZXLwQf_Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: rtc: nuvoton: add NCT3018Y Real Time Clock
To:     Rob Herring <robh@kernel.org>
Cc:     Benjamin Fair <benjaminfair@google.com>,
        alexandre.belloni@bootlin.com, a.zummo@towertech.it,
        Avi Fishman <avifishman70@gmail.com>, ctcchien@nuvoton.com,
        devicetree <devicetree@vger.kernel.org>,
        Tali Perry <tali.perry1@gmail.com>,
        Nancy Yuen <yuenn@google.com>, KWLIU@nuvoton.com,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        KFTING <KFTING@nuvoton.com>, JJLIU0@nuvoton.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, YSCHU@nuvoton.com,
        Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Dear Rob,

thanks a lot.

Rob Herring <robh@kernel.org> =E6=96=BC 2022=E5=B9=B45=E6=9C=8818=E6=97=A5 =
=E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=889:19=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, 17 May 2022 17:29:25 +0800, Medad CChien wrote:
> > Document devicetree bindings for the Nuvoton NCT3018Y Real Time Clock.
> >
> > Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
> > ---
> >  .../bindings/rtc/nuvoton,nct3018y.yaml        | 44 +++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/rtc/nuvoton,nct30=
18y.yaml
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>
B.R.
Medad
