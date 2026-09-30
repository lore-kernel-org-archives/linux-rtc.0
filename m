Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920F949C4AD
	for <linux-rtc@vger.kernel.org>; Wed, 30 Sep 2026 10:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790765272; cv=pass; b=nmMs9/50gTo3RVZX/RTZtlCPplE3JG+Si1Rfn/JbI15Kf3moH6R+1Ljcw333hKLPzSvtqQYBmJjWBahQkU4B8qKIRv3e8An8FDS9aINu8rWOe+XnowgCe0Uo7hYXzW/+gOtwiVXLLpEvyQq4GkDomSf1C1sWUwrH98unp2Ps+dY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790765272; c=relaxed/simple;
	bh=BJbbh5rIl1dEuHCd/t+PuKNfcL4FcSDDMLm4FZ7TkbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lcIaTuRYQwbur6wGxd3AGoJhCN3qMrfTJJCSa4tgW9X3Fp/S+yR+ul38lAz0viUDEP+/k/MSg9pgvnlyb3159GQB9XZyX6hhywgm75S4B4otOxx3aH4je7F6JbpP1iWCnE7UsbHBmyXzSJ5qPBLUcT8BIRIajAEXN5KFt1cmlX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qP3uvbAJ; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qP3uvbAJ"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469b355ffso2203901b3a.1
        for <linux-rtc@vger.kernel.org>; Wed, 30 Sep 2026 03:47:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790765268; cv=none;
        d=google.com; s=arc-20260327;
        b=ihu7UeiLsTbIYHNkNQ9QtMbJOsjAzzzlZeqUJvD4yp7LScsfZP+whADdLfeqb0zvnB
         vgBvCW+Nfm3r0QOQ7oyqDUM1FuppX2Tt3RM8J8ZTRVAHRwxnoPrTWKHGsnuUBi1c1Ei3
         8JVxNOGUhS6XgsOu1tjeECT8EGaiZmkTPW+lCu/Oqj7/qbmOOiCFb2jQ79SdZ+qHCXJG
         knx8JAlAsO0v4b/nzWDuwuaOOHMRnsto2yn7fTY2RVKFR+cAKwXutuDIffUP7Uc1Uf2u
         qbhCi56ZY1FHVsmL6k/nuproNoebwHUuMBMsDE3mFWNCRIxrJUMzlm+K1sFfWyIWllqg
         eMmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=frNDlYzQ/8uu7EJKdkeWFduTnVj3NcJs9Yyw7Sysjok=;
        fh=D8WKn5JhKUVy/zVjI3RmMAmBWEZft63qBDCIVKlXeFA=;
        b=p5f6Qw4ufwBVQO+QgQNY44/mEobpjhBjIDdxOtjyrdRDRcbgDhsUfqPuLnh78wtCKn
         6XyhimcUWnk0ht4dRpO1B+HZku6VzYJHAoPdzH7azBV2GnwepLABgYFonzqfsj9fhQeD
         S4FEHvVWmILEjKuKf72D392JKBPWd8rPB6e6p/K4oejXpeaJ5p/RksfgoT2rOqnCQKPG
         me5cioP08vetpPVw7CkKDdCDrbeaNqwUqO06oaTieCb7AsqNkhSklfHkbUrNh9RmVQy+
         Dll2LG0e3zm+dBAstdl2IyvS/HS0B6W1u3e+nCfA47+cVIJ4NQTFKOBKTHqBbQ6RMkQS
         pZfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790765268; x=1791370068; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=frNDlYzQ/8uu7EJKdkeWFduTnVj3NcJs9Yyw7Sysjok=;
        b=qP3uvbAJc+BVGMRsNqrXSmbmrVa3FHC242tujymtCMQZy5pY8KR4iEIX4tfjUk5E2X
         03V3Z3I6pM/K2uQmX5B9QmRlv/IFau0ifvJqUx0VGpl/735baM6JgLm12MWESCsgaeZO
         sk88OeYx/0dyvyw2eHY61UiJQquOU8yK1U4dxJiEnScX4YptIfZEyvayf/+5ekFB+b4M
         IHtKYTctXJqMWEOY/nu32C4yCBm0/V5ATDL5eG6iIlkFv2NVyWln2wj3iqqi57JJ5dcm
         SGIvKz0l4mcL+ZzZJ8wrRvdf+s1QzaZI4jjnfulgYZ/CGgP307wuA6Mz+wpFnTRZLQyJ
         o1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790765268; x=1791370068;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=frNDlYzQ/8uu7EJKdkeWFduTnVj3NcJs9Yyw7Sysjok=;
        b=PFZS+bqi2sWxZIBJ3MSljGU6u8aQMedW9oB92+XjlHL0UA5pjLqRXoT0y3tl6tNkOu
         aIW+Cg+XNAPxqDM7EH0DyIMO8fvN4UoyHpTx/GwQIZQdZYyJiwPh0/ih9lhBjMal7BfD
         VK1X5PxIMa1fELH6BTGjIpR+BVYC9Y68UZ2QKXIICWWkyO5i/1rP2gaQTWvVZqfk40UR
         o5fI6m1CBQvrEMyruSIM1nB0aro6jNJIon2M8DUBdffuWm6D+1dmr6FPP62uv46nLPtg
         DRGbmOZ4F5Sqq59MedNWHtOhrv6zBiu2YIzg0Ketw7g7ZmKPKdCjOU9E8FVXW7EjpENP
         EGFw==
X-Forwarded-Encrypted: i=1; AKwUvBzwdGMQx5VqkOGJmRe6jOdY+4b8bXZxIBH3QKW86XkY6njm+vhmAHd7qohe5hMzDwfsHgU7z2V2hm0=@vger.kernel.org
X-Gm-Message-State: AFuF++ltT77cKJ2a0SbqanNSU6HLdx/QCf67c+Wq3NH7YwECz1JGWTuL
	OV36lKMak6fLaE2D45m0WKcI/qjszzTqdV/DdPjy7afVhfgGoVdExLGT+W2+bgJNwJIPivb49uw
	XKg/++T0jv36WspBMG4fFDukJWUcsDJk=
X-Gm-Gg: AYBFou2N4bPIBx/fqzb031AbZrdSvkDJQvg5gUyVO5B7sRO5gyJIVWxJw77q+4Y7u1v
	gTGvqqjpMGvVfV/dqcNAMR3PQnwU8xjtWk+aj2A6aHiswpvV+izCdnlRQOklCb7lJmZ+Tp1Xyvh
	kzFljMor/V2r84XJUoMnG4FFUvTbdOj/vqTNfgTIjkkCSokrSUk8sEZuNzRfLMk/2YyXbxeofjg
	Do5I5Cu94yzNio4e9P3DQ5LuIuLR1sKilq2RHzhZ56WtOkxKi28kOxGoJAgRpDLNpASEg87s+vc
	LWM2Ykk+y1HkLfUWBgz2SlzzpFt3+C7ie6oX6v9eLmdzepsQ8jtsrxJuT/+Hf663W8gzhbQ=
X-Received: by 2002:a05:6a00:6c8d:b0:880:3b31:a4bb with SMTP id
 d2e1a72fcca58-8874a89ae36mr654876b3a.20.1790765268145; Wed, 30 Sep 2026
 03:47:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927151016.186493-1-pmazzini@gmail.com> <20260927151016.186493-6-pmazzini@gmail.com>
 <20260930-camouflaged-koel-of-resistance-7b09f5@quoll>
In-Reply-To: <20260930-camouflaged-koel-of-resistance-7b09f5@quoll>
From: Pablo Mazzini <pmazzini@gmail.com>
Date: Wed, 30 Sep 2026 11:47:05 +0100
X-Gm-Features: AclHuK8o0ZcgRpk54PvKUPvKEFYR13nUvSknbUcihyLHytfHbaM-Aa-FPmvKY64
Message-ID: <CAAxh=jsr1M-RHfqPF-hgQnM+RmH_D82=YX==Vn5-r2=1AB9eMA@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] dt-bindings: rtc: sun6i-a31: add Allwinner B288
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Chen-Yu Tsai <wens@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>, 
	Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

Thanks, will fix in v3.

Regards,
Pablo



On Wed, Sep 30, 2026 at 11:10=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On Sun, Sep 27, 2026 at 04:10:10PM +0100, Pablo Mazzini wrote:
> > The B288 RTC wires one alarm interrupt, not two.
> >
> > Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>
> > ---
> >  .../devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml        | 2 ++
> >  1 file changed, 2 insertions(+)
> >
>
> Seems like valid and unaddressed comment from Sashiko, so dropping from
> DT Patchwork.
>
> Best regards,
> Krzysztof
>
