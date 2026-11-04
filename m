Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776240;
	b=YgyBdUos6ch9HePQ6/kS/QB/Bl4i+QGLZxuy3yvRSOtEA87gpNo6fIV/apZ9GaRHvzMo
	 nTKpdyDiZsWR+UkFPIvxKer7blPR/Ldrf6h2AK+w7LYsMELjg4qAx5pIvXScNOuwl0Yks
	 l0TY6N4lXdsjw8vyy18BNsQp5u49RTcb/5iDurbVb3khOxBs/Xi2P73VcWmCKwDRxn4Nq
	 7G09croKnre9YoqoGL1XKHdo8SB7B06m9pY4/XcGtGrRct53Mkwye+9hyhAI0pz/R4f2g
	 P5hSZgzhueiX58HlY2tx6JCwG7s+S/k2N9Ad25AeeJ0Oty5i+LH/fiL492LuF4VYVBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776240;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lLy5f2jv9ygbeiLL4rXL9dD4Ztss6Zzao9ZPhN/ARzI=;
	b=vJH5gWWr57IWj5A/C52RP7pcjTY32wFcDZ3bIvnMuN/0t+/pg2CSeeGCvQggzty47uT8
	 68rqGJ4Z/Ed3kUDzCqb6cfuLInUMp5oB6PCTvRIPwN7N2M4t5PqcUFFIuCMg0LNM+v7OD
	 ivFrZxQiqCLQZPKWDHY/xwED1QOKBmpS8ibrbtUiiRX13VVFq+J+fYWAfKpXz4XcbtQHK
	 111QkP0fUHR9ESQFdpuVMc9BYnLPD3LOX07AGzroi4mOxeV+Qt5OwyGZY+TMhmDJRYWkW
	 dgqZUoY63bg2WLYHF/UzF+04mCeqLBel+vIHr3BhRfA0xuWMmhy74XCGE3cRw7+Rn7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YJWNk8wV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD63606A326;
	Wed,  4 Nov 2026 07:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YJWNk8wV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778BD1F000C1;
	Wed,  4 Nov 2026 07:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793776239;
	bh=lLy5f2jv9ygbeiLL4rXL9dD4Ztss6Zzao9ZPhN/ARzI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YJWNk8wVsUcqRmpt98qNf09ZDS9hlVvB/yjMzG7e+8/EDoiT69yLRRcAYO4oPrhYW
	 0AKl4nQSEgMSbW7xl1iLTQT/Wjsr9OVDErpn2pytPIJoASz2wJ5D4wL7UrcvHhHWkM
	 MxlXiEgRFWE629gxIn44kBW97LtRUsE+T6hoDEKd/DJjtyZ61Urp/XrP3GOEDiTcek
	 tUuO5XgCqKQF4xM+9MMzpUg3zA9XYRcOyayqeviGqpkg7mexmoVpGaxtPPaJ1a8LgO
	 ySl/k0LQSuKJ4OuKdAt/GnvaKEc01om0Z5kFfai7Z1pmmF8Z35CerZLEO/btP2547m
	 jhfvX9cGkwmTw==
Message-ID: <sashiko-outbox-196779@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: arm: qcom: Document Microsoft Surface
 Pro X
Reply-To: sashiko-reviews@lists.linux.dev
To: "Val Packett" <val@packett.cool>
Cc: devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261104070441.74127-2-val@packett.cool>
References: <20261104070441.74127-1-val@packett.cool>
 <20261104070441.74127-2-val@packett.cool>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 07:10:39 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dt-bindings: arm: qcom: commit message duplicates carina and omits =
caspar
--

commit c0354ee6a701cd3d9a5f7b5512415336071339b5
Author: Val Packett <val@packett.cool>

dt-bindings: arm: qcom: Document Microsoft Surface Pro X

This commit replaces the generic microsoft,surface-prox compatible string in
Documentation/devicetree/bindings/arm/qcom.yaml with three model-specific
compatible strings for the Surface Pro X variants.

>     dt-bindings: arm: qcom: Document Microsoft Surface Pro X
>    =20
>     The Surface Pro X tablet was listed as a single generic compatible in
>     dt-bindings, but a device tree using it has not landed upstream.
>    =20
>     Replace it with three model-specific compatibles:
>     * microsoft,cambria for the orginal SQ1 model (with cellular)
>     * microsoft,carina for the Wi-Fi-only (SQ1) model
>     * microsoft,carina for the SQ2 refresh
>    =20
>     Signed-off-by: Val Packett <val@packett.cool>
>
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentat=
ion/devicetree/bindings/arm/qcom.yaml
> index 121ca557ce1ef..74f46697a363f 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -925,7 +925,9 @@ properties:
>        - items:
>            - enum:
>                - lenovo,flex-5g
> -              - microsoft,surface-prox
> +              - microsoft,cambria
> +              - microsoft,carina
> +              - microsoft,caspar

[Severity: Low]
In Documentation/devicetree/bindings/arm/qcom.yaml under
properties.compatible, the schema adds microsoft,cambria, microsoft,carina,
and microsoft,caspar, but the commit message lists microsoft,carina twice
(for both the Wi-Fi-only SQ1 model and the SQ2 refresh) and omits
microsoft,caspar.

Should the Wi-Fi-only (SQ1) entry in the commit description say
microsoft,caspar instead of microsoft,carina?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104070441.7412=
7-1-val@packett.cool?part=3D1
