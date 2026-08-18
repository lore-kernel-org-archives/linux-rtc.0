Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290553515DB
	for <linux-rtc@vger.kernel.org>; Tue, 18 Aug 2026 19:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787081166; cv=pass; b=KYYRJYMQnIjpvuebNCOOZMqbUI+oABcGq20ERQqfHRX7+7DHT9Fg8Aw2ojqFAKT5Vg44POvkDGNaknMfOXAtCWPVqIGTTRDBA4Axlw5swZb4fxQV9LFqOfHRX5c8Pi2DvGGDdgZfZPk6se8wDFsw9R0cnUq6BDNbhsnty465uxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787081166; c=relaxed/simple;
	bh=xD+DTq3vAUF/JATmwOhJZ4DPUbk6IOr1mBsW453i8Qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RC1ZL/qqWvOvb8quFJHw2kgBh0PURyp5IN7rjFHLD/RvknCmxFjX3Spp2adIROXVSanAM0LG2kugEbsSCHo605jJjyY2nZsQsbFAvDeJJ1zPFNrMkj/cx92mjSeC5dhSgwylL3jLlS7mQGjcd+0UPEaQgCc9jeVNtqQTptvXmqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZB+r/Pw/; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZB+r/Pw/"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47de008b020so59642f8f.1
        for <linux-rtc@vger.kernel.org>; Tue, 18 Aug 2026 12:26:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787081163; cv=none;
        d=google.com; s=arc-20260327;
        b=s4jh6cJiHnhIo1ZVnwWNBevA29t5fpNmtJdDr6wT2bsqJHSebHFq6Hjhh3nFEs6IR2
         FnStNyhz/sc7G2aOqApCyoRzC2D9MYVvUcS5bMHrSlcfqzLxa1/It6K/1silcHje5LZb
         KiWVQKUSUqpllEkOOmJLUhOr9svMePBCex+4rFc5s6U5xFp16RH2DuHfaSqN5rMdaYRl
         ZgsuqNpRVsXq5wL0W5OJpyHIZd/34aqbpX/BA+xjd2JoEJh659ixS1FGNdVuhS95rhpO
         xnioNXDUh88s63T26nDGtOs81nQXATYJCugmtWK5icyKXfx1HvPHJ78Uif0AhZVo0OyV
         xmCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=si7KMVjebKUIdClbZKZkuqtNOVYTxZqvVqmzIewFdCU=;
        fh=Il9jsBE6mPJtXXOdl7DBUrLRLnsIgBJHszUy9RUrtvk=;
        b=diMatr6A6oI9jOL7nRFaIbEFLL6XEJwI6KK0ylP5OjE3UR+EV5t1vXpdLb5KIflBz+
         cNTb2xHkClgin8OKQggAn++nl+jMAPaF/DZHyOi4qVwyHOJqnJ9SIVokZzVB7ScqF2VJ
         9VeegERVGakY6RvgABJdshmmn3tvgo823X1aO6P3poVSZh2+L8x/UNr1+5pMEgXsmede
         KPjBHU3i9ALdprXkHlJf5nrkhAlU8YPEDlAM10PLAu40oJOVjUUtKI37el5Y2WsU3L7R
         HTlSth2zaR0juKeRxds9szXtTJ+LQplLih3bB66vyoeYrMYIYNrW8urs3tWXaprCBQtx
         Zx3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787081163; x=1787685963; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=si7KMVjebKUIdClbZKZkuqtNOVYTxZqvVqmzIewFdCU=;
        b=ZB+r/Pw/UkVy8Jj9GPs7DrWnXh15rWQNW/Iz7wlrQawJf4W30/1ZgwDvWVdzylKS4s
         9z5ocxBfC2JnxpiRnxZvGTE6khJb7RpOBsmeUtwVU3EVd39qvqOaIYxoxas5FIVfhRWF
         kpoWfjMkHMlTjgcYx0WqaryOIdiUmMaiMIvyLKDnPEdJAiZGwdo+NZ0drN7Fk8u0Foo2
         7CR46I6R4SO4EskWjMaJsrxReIDQXclpqjVViHEND2QEN+MGyXyPwDpYqRh6op0dtVtQ
         ixwZusHXnILXKOCjZY2JUurhUFC8JbDiDjpbko7yH2dKRF8W+jJ8iLQZHjuEqLq0/Dre
         IE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787081163; x=1787685963;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=si7KMVjebKUIdClbZKZkuqtNOVYTxZqvVqmzIewFdCU=;
        b=gCCWOt5XQ3R+Ksz+wQn/LXzE+EZ1uzbUJ+yxqhinxfCSFoWOwdW39vTQCrdiZdzaSq
         o5nmzJVhqYsVSQyE0KJ6yn48mDe8hRKRJiJPS/DNt2Z6dCG/yuJGYrHERS4LNtR6Ktlj
         +coHl70Tu3T6g1rcVaZlO+CRafJQBmrUbmDdsmc0FFwsuX5YKY3MEaLp48axVXYQTF4E
         7ArUdmQl60tC+uorYJLllm9fvyUwek1PRYgDpvdjrfRWHhXQvdzRgF8wXhje64VytXpw
         J6XRblX4cItJsxpt+Za250q3hQ99c1UqZXNM9FjMj4PgAuh8OW/Cl+azQyVtqDVHeQ42
         CEtQ==
X-Forwarded-Encrypted: i=1; AHgh+RpA+f8XkgpPbP7rS5TX2C2l9pjHIyG25KCenBrKahHqfY47TiRMn8Dybxp9t+4rGmRG06D/C6isMVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMcyN7SdPn8HYULPINg1y5KvQ2UmTTB1679ZN5EnopD6lePqgd
	m6tw8ocFLYcXl3BesXQR2hh1015RYu8CXpjyC8lAlqfW9pSSonnOq/o9QvYQ38ejRV0qsauSJvQ
	krK8c4JPYFS29QV8wKOzQ5DmiANWScJuNK//H
X-Gm-Gg: AR+sD12MS8BX+9LxtqyMP46qELVZs63FLhIKwRSCGrl0QnweZRBMhCSCSU56xGxPLJb
	6eRTilBbshhClmFbcQYKfCruIm+/F+G6kpHxq+ZA6mmaSWADGFuNr9IDV95N/zkiYFsCztAzr8b
	nhuDiWyQSKqigPGLFiv8a0j1vPMWD4eHqsfiwn+QontFjXI+To8H4hNSel+v/IYCofzm/c9U/hk
	7Y0Dh77EJDuTfsedH9gMAvTEAkrWC7XTgll4P4zWg129QBHuTBFm4ofhem5Hi42LYh7QbkNNTHC
	u5vUzRzeaiCA9reQTAWyTV1JFmqTBtE3XY4K3H1hyzLh6rq7gMiHTaxLlHE3/ZlRwFvyuhkvtn2
	WeHrtdqPSDaQVEWaBvnFatNMmov3qRRBhuRKOlH97qTac5Qrw4QoBWl+HELNnnKk=
X-Received: by 2002:adf:e50c:0:b0:482:a9a4:91e7 with SMTP id
 ffacd0b85a97d-482a9ede2f3mr11527757f8f.15.1787081163046; Tue, 18 Aug 2026
 12:26:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706175138.12587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706175138.12587-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706180331.3AD811F000E9@smtp.kernel.org> <aoRB8CrV7ECOG33Y@ninjato>
In-Reply-To: <aoRB8CrV7ECOG33Y@ninjato>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 18 Aug 2026 20:25:34 +0100
X-Gm-Features: AcwNN1XvqpNfeUIyYJ22liaTzQ5Arj1acbogU-h1r2Q7CoLl1dfoF0q-qvhOhnA
Message-ID: <CA+V-a8tJAStSKfsESoEE8vUjgnR+P1yKeYKTnpN43+=MtgbCBw@mail.gmail.com>
Subject: Re: [PATCH v3 12/12] rtc: rzn1: Add support for Renesas RZ/T2H and
 RZ/N2H SoCs
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: sashiko-reviews@lists.linux.dev, linux-rtc@vger.kernel.org, 
	robh@kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, 
	conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

Thank you for the review.

On Tue, Aug 18, 2026 at 12:28=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > Should we add match data to this compatible string to identify the vari=
ant
> > and explicitly reject probe with -EOPNOTSUPP if the clock configuration
> > would require the unsupported SUBU mode?
>
> Correct. Matches also my notes which say that this code
>
> 445                 if (rate !=3D 32768)
> 446                         scmp_val =3D RZN1_RTC_CTL0_SLSB_SCMP;
>
> is wrong when we have a variant which has no SUBU support. Because in
> that case, we need to enable SCMP even for 32768Hz.
>
> So, yes, it is needed to mark which variant has SUBU (RZ/N1 only, likely
> forever) and bail out if no SUBU and no 'xtal'. The above code needs to
> check SUBU support, too.
>
Ok I will introduce OF data to handle this.

struct rzn1_rtc_data {
        bool has_subu;
};

Cheers,
Prabhakar
