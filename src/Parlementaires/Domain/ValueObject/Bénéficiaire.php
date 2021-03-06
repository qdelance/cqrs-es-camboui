<?php

namespace Parlementaires\Domain\ValueObject;

use Parlementaires\Domain\Serializable;

class Bénéficiaire implements Serializable
{
    private $nom;
    private $adresse;

    public function __construct(string $nom, string $adresse)
    {
        $this->guardAgainstEmptyNom($nom);
        $this->nom = $nom;
        $this->adresse = $adresse;
    }

    private function guardAgainstEmptyNom($nom)
    {
        if (empty($nom)) {
            throw new ValeurIncorrecte('Il faut le nom du bénéficiaire quand même');
        }
    }

    public function getNom() : string
    {
        return $this->nom;
    }

    public function getAdresse() : string
    {
        return $this->adresse;
    }

    public function getLignesAdresse() : array
    {
        return explode("\n", $this->adresse);
    }

    public static function deserialize($data)
    {
        return new static($data['nom'], $data['adresse']);
    }

    public function serialize()
    {
        return [
            'nom' => $this->getNom(),
            'adresse' => $this->getAdresse(),
        ];
    }
}