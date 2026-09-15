Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034813A4F51
	for <linux-rtc@vger.kernel.org>; Tue, 15 Sep 2026 09:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789465991; cv=pass; b=bVzQfTF0tmoHSY08X353HPpW1Nb6dokTilQy77H8juo5TkX76laCrnEzym2jguQXKjABr+bvED4brS1L0dQ040YVfNQJxOKmkkLgSmspuOeptJ+rMXypRDST0KftzKIJxe/uJvLkpeWK6ia6r+wWhyCqd7fmRhw/PRwI2bm+aks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789465991; c=relaxed/simple;
	bh=TpVMNylx/LfnqzH4fiOUwjVx51QOsqnFyGwrmo6p0gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IqM0gURfBkZ96Rf55j+NZz2caW7hwmP/+SakDheKCmFoYuqMjKB/K38Q8LOGI4N7mWPJn7eZpx9Q3e8f1nNe1DOEY6Y9w/9QNIjK9MxEtpuV5qpXRn51txJ87RWFt/OCNQpk/KavqtRQrP1dTedJBK3htImXuqMfm37CHIUZ55Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzSAh5z4; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzSAh5z4"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b965f447cso24103345e9.3
        for <linux-rtc@vger.kernel.org>; Tue, 15 Sep 2026 02:53:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789465986; cv=none;
        d=google.com; s=arc-20260327;
        b=bgMh/3qSJmAg79PrUy9HLGbwvuozqHVZn95zUx6sCI3Nq2rkhvg6UOLqynYAQNvX9b
         E08L2YlT+PgNTDybqFH8j7J5361ro39vFMQVQ7JctIvLgxO2h85QW9xuCftFvFDZt1YX
         h6APWa3QP2iC9OGBo98ZRcR/Towqz9se6PBayO504pT98iZWm3hwB8Wg9Or5aQtMzmWG
         Vcg2NGKhNLTr9iAuRyuY+JZ0LmH3xtaXB47sO4k9M6hleZN8uBP4FBE6awlF+q4wI80L
         Crwo/tOd9O90ZfNi+EsCYoMknoFH3gj0peJATfnJB7f2kRif8JAe9oues+i3nzlufVom
         2Jlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VRIRT8lVdgTRcvAyHF4oWWO/J36h42SC/PtuITyg0U8=;
        fh=aWU37OVXdfO4eTCveLfySWljmF/zcXv1nY6uLuimULQ=;
        b=AQ/zJtIfa/ZN5PFeqkLtBQt+tqNQNP29jkiQA5eMeJ0f0QWV1eMOGxZJN7JhscR81q
         Pa5nhj9EZ0cisceImaL7zizD/zLreGu4VOY3lWjJGy/gjrUzQelURkJBDjFtbH4ZDE9u
         V4OVy+TFeW2m4elMBlZCw098auC1oqm4Hp2k1T1Hmdfd12rQx2lH85MJDpPKmSrFk6V5
         u/P1lYg74jg/vaPh+c47CbTIMCTUvc4w4V+xIXfMtyK47x2EDxpSO12SnhRSDeQC9pSw
         PlRaXOyNUz4iwvq2TN3DIo7x0vvkiW4pIC3pHYsK4uvsDoa2XcQsqTfi1pepYUk1J8cG
         OYaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789465986; x=1790070786; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VRIRT8lVdgTRcvAyHF4oWWO/J36h42SC/PtuITyg0U8=;
        b=FzSAh5z4Por1PRchL88s4zfB59l7JqqjNyY9lKi2FQmSUIkn3wTdZQhx1RN38gfqhf
         PTc+hcts0izlxHDMsF40O0z9+XoI6ur2ISGtCsC24FfpIqm+Ps2MTCTqadxX5fNWQM3l
         iq2L9oI4ljCOolrewfhUMhlbnn1DAD5ZsYvnahJrA6Taa2vOv1xiNWKUi3KhIAweF1gg
         Du2NxVZXDiM32MvU1ps7uAt6BVAORUE5JfH+65fpL315bxbmTWdhE5oIPe1wYSy0esMM
         Cy98sWMXxPILdXY1t3HTGohI2Gv0lsjsjSkCVcjcr4y0dJ9DdzxlP/2ljdtWp2DnpmIM
         x56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789465986; x=1790070786;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VRIRT8lVdgTRcvAyHF4oWWO/J36h42SC/PtuITyg0U8=;
        b=j2EHjaOStVMY3bTVmbH/Npmw0xSZxZehE5kbcYX+q/1Jf4VGlDO+WEFuSjqtTyk2ht
         OSYdPVNQP9dllYjw6IqQBPkcfEb5GXR0QQKeIVMmR9USTUuaqRi/tq8XHisQZ6Z1sLv8
         UHSFu/dfBHnxoCtNLrvjq/uKmsEgW6tq7MixrF4F3cgYcJ0+r7jp2MD/241GLS039Qlh
         Cd6cF4Lg6pAG5HEOdXYEm1xALsAd42fjIhztGTrTyFYfrP6hwssN/qqrGtkPjIJX70mw
         NRWq0hYwAvvuJKk4kyUqwkQROUpP+yImIZ9zbtul7KHo7KWjjPpdb8SQVBVz0DDUFGc3
         Cjsg==
X-Forwarded-Encrypted: i=1; AKwUvBwFNQUoxs3Fs9PSqqg1WVHXzW2zoOmW+sq4RtLoY+BG+OkTApcKG/Ed+R2S055cUcqVmGSTNs5+J/4=@vger.kernel.org
X-Gm-Message-State: AFuF++mYCxw3Yh3XZjfqsXQtwKDSydxwupPHw9ABcnA9HsGgCNERnv4Q
	ny30Sna1T5m3QNGu5ok/YnmWuuMD5w1+ETsTgt7Nbv2Fei+lwNq59p4y53drcOZYI+xY3jLf6B4
	buq3FajSbxRV+490HCnwaBTn/pjvjLYc=
X-Gm-Gg: AYBFou2PojaCk/xCTq1Yqq0UzQnLcCDGGsqnHAknd4gIpeQ+3txlN4hkDdYmjr4foPi
	qJG7pdsABBwjg19Ch2Kay7Upb8UK8aoyI4FKj3JwrswK5roVJKGx61Rg9gNp1QEfdpboes236Ho
	Y8BZaOIp8yCZTrUUIYpuOJL6pC0xCYYyB8MENr5hTFUmulKb/xTsIVgcZuQK1MaNf6zheaxN0jK
	C6rYDjOOvH5+YXN9Zwvd51XtLS89Y8UTEN1TwIG+Bi0EjNQ95Pg1o/+qKs5xd02RaihKSjOXk7t
	NWYB2C1mDR+WsIi65hZ3yNYs+P5enntO84jQfFZMFXalrsyZES7tSULjVlfM9u+gE5l1HylxFT7
	0AjOdbyqE7t+7H6aONAJ3W/4yMhqF5E5xTg3inztw
X-Received: by 2002:a05:600c:3d92:b0:49e:6777:da79 with SMTP id
 5b1f17b1804b1-49e7a678649mr84046735e9.26.1789465985857; Tue, 15 Sep 2026
 02:53:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914211826.73727-8-wsa+renesas@sang-engineering.com> <20260914211826.73727-10-wsa+renesas@sang-engineering.com>
In-Reply-To: <20260914211826.73727-10-wsa+renesas@sang-engineering.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 15 Sep 2026 10:52:40 +0100
X-Gm-Features: AcwNN1Udue3OHWdECCoWcwp7qk6bAA1DwRbc1YPBqEjPdz7MomEMSfQm-K8-eUQ
Message-ID: <CA+V-a8sq0s8x+Wrk71ncNER_MS=FtLTsxf3AK2UxrTDRqB+msA@mail.gmail.com>
Subject: Re: [PATCH 2/6] dt-bindings: rtc: rzn1: add SoC names next to their IDs
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 10:19=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> This helps maintaining because the numbers are easy to confuse.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  .../devicetree/bindings/rtc/renesas,rzn1-rtc.yaml      | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml =
b/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
> index e96007981c34..7ea77cd0bee1 100644
> --- a/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
> @@ -14,14 +14,14 @@ properties:
>      oneOf:
>        - items:
>            - enum:
> -              - renesas,r9a06g032-rtc
> -          - const: renesas,rzn1-rtc
> +              - renesas,r9a06g032-rtc # RZ/N1D
> +          - const: renesas,rzn1-rtc   # RZ/N1
>
> -      - const: renesas,r9a09g077-rtc
> +      - const: renesas,r9a09g077-rtc  # RZ/T2H
>
>        - items:
> -          - const: renesas,r9a09g087-rtc
> -          - const: renesas,r9a09g077-rtc
> +          - const: renesas,r9a09g087-rtc  # RZ/N2H
> +          - const: renesas,r9a09g077-rtc  # RZ/T2H
>
>    reg:
>      maxItems: 1
> --
> 2.53.0
>
>
