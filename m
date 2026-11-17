Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794922751;
	b=R3d/77g60AVuTvY+NWCToW9f+89OnhnDsb4JkrXD9Ywca0jf2X+TLYWDg3NdH8HQaqUu
	 5MJqVeD8FY2ZkPfyWH6Ltc53wxxpulPDDoCOAVE+q7XHP0emBxz4KTq8v5P73WP89BM/o
	 Gr+NUyJkUp224JXsakLTX5JHPHRGA5sfP0iE4+RlqemDdOvGHNfWztL0zuSFHiP7RzOl1
	 IenvkuX2J1RHvviIYEQvGqPNlA7ifPN6Vg47qFT0cTnUsu/SmhFRxLQg05jUhAOocAC+p
	 xQJRHZ78dhaC9WZrjvXu3YqVSUT2UiS/n55cTijTYSN6Z91Fo0GJ30Y7tKx9AKqxYGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794922751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=KPHA9VXi6250Y2f3/2jRY7wM7Io1FieoW17lwl35AjE=;
	b=BT81/Tx9HgRU9EdKi7E/YZ1Jc9UdqTwt/uAC6+LgZgd8uxaTb5dVESd40v1MGk3/Mo7J
	 yuk7Q8Shjq8qvJ+M3tsXCv85oxluMwQEceoitA0cDORkSvCiFMd6IUeo8qKeX7G55WsLG
	 fbsFVOUGPu4TtWTg4ywsMo2lHDbSrzj8GcMDB7zM3U3rl/t/ENNxfRfv8jqUNB7MLYhYz
	 JCmqTBXjoj9J+xLOq+YzS0IAl8z3DyvKBKFLOckVoFarVjaQyhwFiDSisfD2fzgb0xk/g
	 gb50c6Au9RvLud01/SOsPJPO7CU/Pea0gxNHaVVlr2fjj5Vm+zE1pqx1nSBiVkI3yIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aa74ewLM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.49
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7085E606A31C
	for <linux-rtc@vger.kernel.org>; Tue, 17 Nov 2026 13:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7085E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aa74ewLM
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5c1479be604so631461e87.1
        for <linux-rtc@vger.kernel.org>; Tue, 17 Nov 2026 05:39:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794922750; cv=none;
        d=google.com; s=arc-20260327;
        b=rQmg/TCw3p3wCkWzqAiWR0LSGDvrhd2Q0khdmnZ6M8GMUSxtqB0r0A8agI5oIj7sX7
         p9ZHVZBtYci6DWm3kCFmxwyqoRNSibO356t3mDrfiPwBN1NCsBsmMybwamT6t41pezNt
         YYZs3bNYZjcrsA+7zubl1Q+A/KflbCxY+Z0ppFzxcaCy5WE5y5EJguMAsGRLq2i/ulga
         MMC2p/fM1jSzOttbsJ73CniyNKN24UEn0Il1Fr3ob6hIdrtK5nLDkNp1VZvJrwk3j4tl
         CWY2hlYHeSMxLjoGhMR8rzljwFQMtUP8/+v/F+Rphc4LMxpGP7tR8H+r4gHAdOAm3z5K
         6CNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KPHA9VXi6250Y2f3/2jRY7wM7Io1FieoW17lwl35AjE=;
        fh=6AGiUmdWcWuJ6/irKTj/urGjseZRnwIyPgGyF3hKMDM=;
        b=aXhYRQlujIitkqarXfmWQSWsSOcLWoLslLNiSxkNZvRJAshvxPdlPGvs2WkUE/3RpF
         ubusKywVG4f+2MbRfmUsE4MTIEqRo1a1o+WZciSJxStXoAALikWzfE64dZ/iTHBIJiuV
         3FaqRnrhdZt0rVhel9AyfK+ZgBUxkHcp+0s0P4UH/td66DcIQxsQwdVjUkLDnsDERz+V
         ZlA+ERPcFpCIGPqZN4+26TJpIA1oPkU9MrXRUZNW4yO25OPaUZ1Ega87qn5rh2el63Bq
         BfAoGleKyIQuKQz8ZZoD6S0IFAvm2HZJuubav4czUWrvgqi6xK3yz5XFC52uqSRrIUCo
         gUTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794922750; x=1795527550; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KPHA9VXi6250Y2f3/2jRY7wM7Io1FieoW17lwl35AjE=;
        b=aa74ewLM8u0pFHArMerl/NPIA6QhrkWCQBAmJPBUfpkbuq4xGmBhCjWGQnxy02mRdV
         e1lolqblAUV2BAG+cbrUvFrCxxXtQE4Q06b9mE9HxMofJGUkHFXVn9qCU33RhoXCkPRn
         UlU1I3oi/e7p061U/PQK98sG2jlG36M2h8C8CN1hnb8rfkdR515P3YM5ojFRhPvGB2+v
         oLj9jmgk9rDqlXufA3fMkgCUJ9NSZkGrf/qP+HyssQRJNCT6L0rvjbOULQgGPInYv4Nk
         ZjWtj+wI6BYs9PEyxyxubZdatQhA7ZCs/s2itv3SOJ6liYcC27NRWxzxvTv/3pvXSHVk
         TF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794922750; x=1795527550;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KPHA9VXi6250Y2f3/2jRY7wM7Io1FieoW17lwl35AjE=;
        b=rjcRvZ43d4wenr1nvsOJfp7z9W6eSoEHV48Un1MzmGTdCzwRRXeBtey0n+TyMqGL6j
         11iH33b1rHZNtScGiJrQzRZMwhMPcKPw5Tth/ddR/qjU8W7aIlpkQl+kV1FgmRmW8O0O
         Vp3a2vZrGrVx8svD1wtTXJRCjmMs5/KQ6L/fNsVi/x39OAEc1TyCpONUAlad/EAt7EEO
         Zc04B+u3qbdK9wpXp8t0wP6cchx0qaGWPKkgNx9TytIV5kiBjEblG8GZJVxSzyN04AAp
         gSqMGgheWyIw4uCgTo2CyWzM6pBkOfo6o5KWJpdeX9JkUuOYq/Fbrpcg7lQvKiTVsPZ+
         iffQ==
X-Gm-Message-State: APuU4Z9qvOF+WddC3fW2vzEFHFtj6QzwPSUyX7bHU/eA96HTCHYT6KH3
	R9tp97sDbtYmdq693xuDUrheNa0qO8jzVuwxfemxo2kPwC6Mt6XnISPE7oYF2mm+qqC2iP4xY2D
	A6CowHpMqumdIWaGg5pR+xQfY/pPzlOzelQ==
X-Gm-Gg: AYBFou3tU4sdFqiRn8yVHG7nTidzjX3iKfX/Q4MOZIhF7VO8YvgVj88beJSNhW2lPJp
	E8wxh2AA2L3wPKZO968rrr0C5QVBJRPr2ZND8VCbqaSaO/HjOspz2xa6AkjEqt4oqoyxIvajwAP
	+KiREQJalfwOm7WLEbBC0vJLnyyMozwLppov8YZV46ps6qazfGi4BYJHwgc1RHHWcOMRPPUogTr
	BBiiRBUjhv8lhbPwTwuACr54JRacoH8lYOjHFOJwAC3vVjNLnZXTYeDIjNx3/Vh5iKPxbaBbLDo
	lK3FH/9/63DcGzsdggL+XLhqTXSzj5275bCSQJuRhb11GngFH34sGkpXsTVBnwRVIRjU1NENjgn
	nyAZvx7z9PfnZXUGtUStHESc6Vkw3yzttKDwnjcxFEqz6n63LfLwb/Pgkscmm8YmZnla7/m7r0i
	AEnyWnKM9D4zvtpc7tHkhDcMY42A==
X-Received: by 2002:ac2:4bc9:0:b0:5bf:b9e2:f69 with SMTP id
 2adb3069b0e04-5c17079512amr6512588e87.26.1794922749189; Tue, 17 Nov 2026
 05:39:09 -0800 (PST)
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260902125257.9882-1-festevam@gmail.com>
In-Reply-To: <20260902125257.9882-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 17 Nov 2026 10:38:57 -0300
X-Gm-Features: Aa3M54oyAHsbFD8nMq9jaBt1dZLWrjTBp8OiUR1T9eI3IYbqLJKefoRVxzZ6SLk
Message-ID: <CAOMZO5CcPr7EqU1GWoNXS5rkQuiximaH3T_Ek9DeFbnHGNeFew@mail.gmail.com>
Subject: Re: [PATCH RESEND v4] rtc: abx80x: Don't warn about oscillator
 failure after POR
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org, seanga2@gmail.com, 
	Sean Anderson <sean.anderson@seco.com>, Fabio Estevam <festevam@nabladev.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 9:53=E2=80=AFAM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> From: Sean Anderson <sean.anderson@seco.com>
>
> According to the datasheet, the "oscillator failure" bit is set
>
>   ...on a power on reset, when both the system and battery voltages have
>   dropped below acceptable levels. It is also set if an Oscillator Failur=
e
>   occurs....
>
> From testing, this bit is also set if a software reset is initiated.
>
> This bit has a confusing name; it really tells us whether the time data
> is valid. We clear it when writing the time. If it is still set, that
> means there is a persistent issue, such as an oscillator failure,
> instead of a transient one, such as power loss.
>
> Because there are several other reasons which might cause this bit to be
> set, including booting for the first time or a battery failure, do not
> warn about oscillator failures unconditionally. This may cause system
> integrators to waste time investigating the wrong issue.
>
> Continue printing a message about invalid time data before the time has
> been set. Only report an oscillator failure after the driver has
> successfully written the time and cleared the flag.
>
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> Signed-off-by: Fabio Estevam <festevam@nabladev.com>
> ---
> Changes since v3:
> - Rebase onto current mainline.
> - Fix commit message wording and typos.

Ping?
